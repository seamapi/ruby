// The Metalsmith plugin that generates the Ruby SDK route files.
// Structured to mirror the javascript-http codegen plugin (lib/connect.ts).
//
// The blueprint from @seamapi/blueprint drives all generated output: resources
// come from blueprint.resources (plus discriminated action attempts and the
// pagination resource), and clients come from blueprint.routes and
// blueprint.namespaces.

import type {
  Blueprint,
  Endpoint,
  Property,
  Resource,
  Response,
} from '@seamapi/blueprint'
import { pascalCase } from 'change-case'
import type Metalsmith from 'metalsmith'

import { convertCustomResourceName } from './custom-resource-name-conversions.js'
import { rubyParameterType } from './handlebars-helpers.js'
import { setClientLayoutContext } from './layouts/client.js'
import { setImportsLayoutContext } from './layouts/imports.js'
import {
  type DiscriminatedVariantSource,
  getCommonScalarProperties,
  setResourceLayoutContext,
} from './layouts/resource.js'
import { setRoutesFileLayoutContext } from './layouts/routes-file.js'
import type { ClientMethod, ClientModel } from './ruby-client.js'

interface Metadata {
  blueprint: Blueprint
}

const routesPath = 'lib/seam/routes'
const resourcesPath = 'lib/seam/resources'

export const routes = (
  files: Metalsmith.Files,
  metalsmith: Metalsmith,
): void => {
  const { blueprint } = metalsmith.metadata() as Metadata

  const resourceNames: string[] = []

  for (const [name, resource] of getResources(blueprint)) {
    files[`${resourcesPath}/${name}.rb`] = {
      contents: Buffer.from('\n'),
      layout: 'resource.hbs',
      ...setResourceLayoutContext(name, resource.properties, resource),
    }
    resourceNames.push(name)
  }

  const clients = getClients(blueprint)

  const clientNames: string[] = []
  for (const cls of clients.values()) {
    files[`${routesPath}/${cls.namespace}.rb`] = {
      contents: Buffer.from('\n'),
      layout: 'client.hbs',
      ...setClientLayoutContext(cls),
    }
    clientNames.push(cls.namespace)
  }

  files[`${resourcesPath}/index.rb`] = {
    contents: Buffer.from('\n'),
    layout: 'imports.hbs',
    ...setImportsLayoutContext(resourceNames, ['require "seam/base_resource"']),
  }

  files[`${routesPath}/index.rb`] = {
    contents: Buffer.from('\n'),
    layout: 'imports.hbs',
    ...setImportsLayoutContext(clientNames, []),
  }

  files[`${routesPath}/routes.rb`] = {
    contents: Buffer.from('\n'),
    layout: 'routes.hbs',
    ...setRoutesFileLayoutContext(getTopLevelClientNamespaces(blueprint)),
  }
}

type ResourceDocumentation = Pick<
  Resource,
  'description' | 'isDeprecated' | 'deprecationMessage'
>

interface ResourceSource extends ResourceDocumentation {
  properties: Property[]
  discriminator?: string
  variants?: DiscriminatedVariantSource[]
}

const createActionAttemptBaseProperties = (
  variants: DiscriminatedVariantSource[],
): Property[] => {
  const propertyLists = variants.map(({ properties }) => properties)
  const common = getCommonScalarProperties(propertyLists)
  const nested = ['error', 'result'].flatMap((name) => {
    const occurrences = propertyLists.map((properties) =>
      properties.find((property) => property.name === name),
    )
    if (
      occurrences.some(
        (property) => property == null || property.format !== 'object',
      )
    ) {
      return []
    }

    const objects = occurrences as Array<
      Extract<Property, { format: 'object' }>
    >
    const first = objects[0]
    if (first == null) return []
    return [
      {
        ...first,
        description:
          name === 'error' ? 'Error associated with the action.' : '',
        isNullable: true,
        properties: getCommonScalarProperties(
          objects.map(({ properties }) => properties),
        ),
      },
    ]
  })

  return [...common, ...nested].sort((a, b) => a.name.localeCompare(b.name))
}

const getResources = (
  blueprint: Blueprint,
): Array<[string, ResourceSource]> => {
  const resources = new Map<string, ResourceSource>()

  for (const resource of blueprint.resources) {
    resources.set(resource.resourceType, resource)
  }

  const eventResource = resources.get('event')
  if (eventResource != null) {
    resources.set('event', {
      ...eventResource,
      description:
        'Represents a Seam event. Known event types load as subclasses; unknown event types remain SeamEvent instances for forward compatibility.',
      discriminator: 'event_type',
      variants: blueprint.events.map((event) => ({
        discriminatorValue: event.eventType,
        description: event.description,
        properties: event.properties,
      })),
    })
  }

  if (blueprint.actionAttempts.length > 0) {
    const variants = blueprint.actionAttempts.map((actionAttempt) => ({
      discriminatorValue: actionAttempt.actionAttemptType,
      description: actionAttempt.description,
      // Action attempts can return null for both fields while pending. The
      // blueprint currently loses that per-status nullability upstream.
      properties: actionAttempt.properties.map((property) =>
        ['error', 'result'].includes(property.name)
          ? { ...property, isNullable: true }
          : property,
      ),
    }))
    resources.set('action_attempt', {
      description:
        'Represents a Seam action attempt. Known action types load as subclasses; unknown action types remain ActionAttempt instances for forward compatibility.',
      isDeprecated: false,
      deprecationMessage: '',
      properties: createActionAttemptBaseProperties(variants),
      discriminator: 'action_type',
      variants,
    })
  }

  if (blueprint.pagination != null) {
    resources.set('pagination', {
      ...blueprint.pagination,
      isDeprecated: false,
      deprecationMessage: '',
    })
  }

  return [...resources.entries()].sort(([a], [b]) => a.localeCompare(b))
}

interface ClientSource {
  name: string
  parentPath: string | null
  endpoints: Endpoint[]
}

const getClients = (blueprint: Blueprint): ClientModel[] => {
  const sources = new Map<string, ClientSource>()

  // Namespaces without a route of their own (e.g. /acs) become clients that
  // only expose child clients.
  for (const namespace of blueprint.namespaces) {
    sources.set(namespace.path, {
      name: namespace.name,
      parentPath: namespace.parentPath,
      endpoints: [],
    })
  }

  for (const route of blueprint.routes) {
    sources.set(route.path, {
      name: route.name,
      parentPath: route.parentPath,
      endpoints: route.endpoints,
    })
  }

  const paths = [...sources.keys()].sort()

  const clients = new Map<string, ClientModel>()
  for (const path of paths) {
    const source = sources.get(path)
    if (source == null) continue
    const namespace = getClientNamespace(path)
    clients.set(path, {
      name: pascalCase(namespace),
      namespace,
      methods: source.endpoints.map(createClientMethod),
      childClientIdentifiers: [],
    })
  }

  for (const path of paths) {
    const source = sources.get(path)
    if (source?.parentPath == null) continue
    const parent = clients.get(source.parentPath)
    parent?.childClientIdentifiers.push({
      clientName: pascalCase(getClientNamespace(path)),
      namespace: source.name,
    })
  }

  return [...clients.values()]
}

const getClientNamespace = (path: string): string =>
  path.slice(1).split('/').join('_')

const getTopLevelClientNamespaces = (blueprint: Blueprint): string[] => {
  const namespaces = [...blueprint.namespaces, ...blueprint.routes]
    .filter(({ parentPath }) => parentPath == null)
    .map(({ path }) => getClientNamespace(path))
  return [...new Set(namespaces)].sort()
}

const createClientMethod = (endpoint: Endpoint): ClientMethod => {
  const { returnPath, returnResource } = getEndpointReturn(endpoint.response)

  return {
    methodName: endpoint.name,
    httpMethod: endpoint.request.preferredMethod,
    description: endpoint.description,
    isDeprecated: endpoint.isDeprecated,
    deprecationMessage: endpoint.deprecationMessage,
    responseDescription: endpoint.response.description,
    requiresAtLeastOneParameter:
      endpoint.request.hasRequiredParameters &&
      endpoint.request.parameters.every(({ isRequired }) => !isRequired),
    path: endpoint.path,
    parameters: endpoint.request.parameters.map((parameter) => ({
      name: parameter.name,
      description: parameter.description,
      isDeprecated: parameter.isDeprecated,
      deprecationMessage: parameter.deprecationMessage,
      rubyType: rubyParameterType(parameter),
      required: parameter.isRequired,
      position:
        endpoint.name === 'get' && parameter.name === `${returnPath}_id`
          ? 0
          : undefined,
    })),
    returnPath,
    returnResource,
  }
}

const getEndpointReturn = (
  response: Response,
): Pick<ClientMethod, 'returnPath' | 'returnResource'> => {
  if (response.responseType === 'void') {
    return { returnPath: '', returnResource: null }
  }

  const { responseKey, resourceType } = response

  if (resourceType === 'unknown') {
    // Batch responses hold multiple resource types keyed by batch key, which
    // the Batch resource models directly.
    if (responseKey === 'batch') {
      return { returnPath: 'batch', returnResource: 'Batch' }
    }
    return { returnPath: '', returnResource: null }
  }

  return {
    returnPath: responseKey,
    returnResource: pascalCase(convertCustomResourceName(resourceType)),
  }
}
