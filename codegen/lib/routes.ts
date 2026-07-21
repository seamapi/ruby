// The Metalsmith plugin that generates the Ruby SDK route files.
// Structured to mirror the javascript-http codegen plugin (lib/connect.ts).
//
// The blueprint from @seamapi/blueprint drives all generated output: resources
// come from blueprint.resources (plus the merged action_attempt and the
// pagination resources), and clients come from blueprint.routes and
// blueprint.namespaces.

import type {
  Blueprint,
  Endpoint,
  Property,
  Response,
} from '@seamapi/blueprint'
import { pascalCase } from 'change-case'
import type Metalsmith from 'metalsmith'

import { convertCustomResourceName } from './custom-resource-name-conversions.js'
import { setClientLayoutContext } from './layouts/client.js'
import { setImportsLayoutContext } from './layouts/imports.js'
import { setResourceLayoutContext } from './layouts/resource.js'
import { setRoutesFileLayoutContext } from './layouts/routes-file.js'
import type { ClientMethod, ClientModel } from './ruby-client.js'
import {
  resourceErrorRb,
  resourceErrorsSupportRb,
  resourceWarningRb,
  resourceWarningsSupportRb,
} from './static-resources.js'

interface Metadata {
  blueprint: Blueprint
}

const routesPath = 'lib/seam/routes'
const resourcesPath = `${routesPath}/resources`
const clientsPath = `${routesPath}/clients`

export const routes = (
  files: Metalsmith.Files,
  metalsmith: Metalsmith,
): void => {
  const { blueprint } = metalsmith.metadata() as Metadata

  const resourceNames: string[] = []

  const staticResources: Array<[string, string]> = [
    ['resource_error', resourceErrorRb],
    ['resource_warning', resourceWarningRb],
    ['resource_errors_support', resourceErrorsSupportRb],
    ['resource_warnings_support', resourceWarningsSupportRb],
  ]
  for (const [name, contents] of staticResources) {
    files[`${resourcesPath}/${name}.rb`] = { contents: Buffer.from(contents) }
    resourceNames.push(name)
  }

  for (const [name, properties] of getResources(blueprint)) {
    files[`${resourcesPath}/${name}.rb`] = {
      contents: Buffer.from('\n'),
      layout: 'resource.hbs',
      ...setResourceLayoutContext(name, properties),
    }
    resourceNames.push(name)
  }

  const clients = getClients(blueprint)

  const clientNames: string[] = []
  for (const cls of clients.values()) {
    files[`${clientsPath}/${cls.namespace}.rb`] = {
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

  files[`${clientsPath}/index.rb`] = {
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

const getResources = (blueprint: Blueprint): Array<[string, Property[]]> => {
  const resources = new Map<string, Property[]>()

  for (const resource of blueprint.resources) {
    resources.set(resource.resourceType, resource.properties)
  }

  // The event resource only has the properties common to all events, but the
  // SDK exposes a single SeamEvent class, so it needs an accessor for every
  // property of every event variant.
  const eventProperties = resources.get('event')
  if (eventProperties != null) {
    resources.set(
      'event',
      mergeProperties([
        eventProperties,
        ...blueprint.events.map((event) => event.properties),
      ]),
    )
  }

  // Action attempts are one blueprint entry per action type, but the SDK
  // exposes a single ActionAttempt class.
  if (blueprint.actionAttempts.length > 0) {
    resources.set(
      'action_attempt',
      mergeProperties(
        blueprint.actionAttempts.map(
          (actionAttempt) => actionAttempt.properties,
        ),
      ),
    )
  }

  if (blueprint.pagination != null) {
    resources.set('pagination', blueprint.pagination.properties)
  }

  return [...resources.entries()].sort(([a], [b]) => a.localeCompare(b))
}

const mergeProperties = (propertyLists: Property[][]): Property[] => {
  const merged = new Map<string, Property>()
  for (const properties of propertyLists) {
    for (const property of properties) {
      if (!merged.has(property.name)) merged.set(property.name, property)
    }
  }
  return [...merged.values()].sort((a, b) => a.name.localeCompare(b.name))
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
    if (namespace.isUndocumented) continue
    sources.set(namespace.path, {
      name: namespace.name,
      parentPath: namespace.parentPath,
      endpoints: [],
    })
  }

  for (const route of blueprint.routes) {
    if (route.isUndocumented) continue
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
      methods: source.endpoints
        .filter((endpoint) => !endpoint.isUndocumented)
        .map(createClientMethod),
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
  const namespaces = [
    ...blueprint.namespaces.filter((namespace) => !namespace.isUndocumented),
    ...blueprint.routes.filter((route) => !route.isUndocumented),
  ]
    .filter(({ parentPath }) => parentPath == null)
    .map(({ path }) => getClientNamespace(path))
  return [...new Set(namespaces)].sort()
}

const createClientMethod = (endpoint: Endpoint): ClientMethod => {
  const { returnPath, returnResource } = getEndpointReturn(endpoint.response)

  return {
    methodName: endpoint.name,
    path: endpoint.path,
    parameters: endpoint.request.parameters
      .filter((parameter) => !parameter.isUndocumented)
      .map((parameter) => ({
        name: parameter.name,
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
