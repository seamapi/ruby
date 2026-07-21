// The Metalsmith plugin that generates the Ruby SDK route files.
// Ported from @seamapi/nextlove-sdk-generator lib/generate-ruby-sdk/generate-ruby-sdk.ts,
// restructured to mirror the javascript-http codegen plugin (lib/connect.ts).
//
// The blueprint from @seamapi/blueprint drives the iteration order and the
// route, endpoint, and namespace structure. The raw OpenAPI spec is still
// consulted wherever the previous nextlove generator derived output from data
// the blueprint normalizes differently; each of those spots is marked with a
// TODO so they can migrate to the blueprint once output is allowed to change,
// and the supporting code lives in files marked TEMPORARY that will be deleted
// with them.

import type { Blueprint } from '@seamapi/blueprint'
import * as types from '@seamapi/types/connect'
import { pascalCase } from 'change-case'
import type Metalsmith from 'metalsmith'

import { convertCustomResourceName } from './custom-resource-name-conversions.js'
import { ignoredEndpointPaths } from './endpoint-rules.js'
import { setClientLayoutContext } from './layouts/client.js'
import { setImportsLayoutContext } from './layouts/imports.js'
import { setResourceLayoutContext } from './layouts/resource.js'
import { setRoutesFileLayoutContext } from './layouts/routes-file.js'
import { getFilteredRoutes } from './openapi/get-filtered-routes.js'
import { getParameterAndResponseSchema } from './openapi/get-parameter-and-response-schema.js'
import { mapParentToChildResources } from './openapi/map-parent-to-children-resource.js'
import type { ObjSchema, OpenapiSchema } from './openapi/types.js'
import type { ClientModel } from './ruby-client.js'
import {
  resourceErrorRb,
  resourceErrorsSupportRb,
  resourceWarningRb,
  resourceWarningsSupportRb,
} from './static-resources.js'

interface Metadata {
  blueprint: Blueprint
}

const openapi = types.openapi as unknown as OpenapiSchema

const routesPath = 'lib/seam/routes'
const resourcesPath = `${routesPath}/resources`
const clientsPath = `${routesPath}/clients`

export const routes = (
  files: Metalsmith.Files,
  metalsmith: Metalsmith,
): void => {
  const { blueprint } = metalsmith.metadata() as Metadata

  // TODO: Derive the parent to child resource map from blueprint.namespaces
  // once generated output is allowed to change.
  const rawRoutes = getFilteredRoutes(openapi)
  const parentToChildResourcesMap = mapParentToChildResources(rawRoutes)

  const resourceNames: string[] = []

  // Static resource support files, in the order the nextlove generator emits
  // them (before the schema-derived resources).
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

  // TODO: Use blueprint.resources, blueprint.events, and blueprint.actionAttempts
  // once generated output is allowed to change. Blueprint omits some schemas,
  // reorders others, and collapses integer to number, so the raw OpenAPI schemas
  // are used to keep the output identical.
  for (const [snakeName, schema] of Object.entries(
    openapi.components.schemas,
  )) {
    files[`${resourcesPath}/${snakeName}.rb`] = {
      contents: Buffer.from('\n'),
      layout: 'resource.hbs',
      ...setResourceLayoutContext(snakeName, schema as ObjSchema),
    }
    resourceNames.push(snakeName)
  }

  const clientMap = new Map<string, ClientModel>()

  const processClient = (resourceName: string): void => {
    const childClientIdentifiers = (
      parentToChildResourcesMap[resourceName] ?? []
    ).map((childResource) => ({
      clientName: pascalCase(`${resourceName} ${childResource}`),
      namespace: childResource,
    }))
    const className = pascalCase(resourceName)

    clientMap.set(className, {
      name: className,
      namespace: resourceName,
      methods: [],
      childClientIdentifiers,
    })
  }

  for (const route of blueprint.routes) {
    for (const endpoint of route.endpoints) {
      const post = openapi.paths[endpoint.path]?.post
      if (post == null) continue

      // TODO: Filter on endpoint.isUndocumented and route.isUndocumented from
      // the blueprint once generated output is allowed to change. The raw
      // OpenAPI extensions are used here to exclude exactly the same endpoint
      // set as the previous nextlove generator.
      if (post['x-undocumented'] != null) continue
      if ((post.summary ?? '').startsWith('/seam/')) continue
      if (post['x-fern-sdk-group-name'] == null) continue
      if (ignoredEndpointPaths.includes(endpoint.path)) continue

      const groupNames = [...post['x-fern-sdk-group-name']]
      const [baseResource] = groupNames
      const namespace = groupNames.join('_')
      const className = pascalCase(namespace)

      if (!clientMap.has(className)) {
        processClient(namespace)
      }

      /*
        Special case when we don't have routes for a base resource and thus a
        respective x-fern-sdk-group-name for ex. /noise_sensors
      */
      if (baseResource != null && !clientMap.has(pascalCase(baseResource))) {
        processClient(baseResource)
      }

      const cls = clientMap.get(className)

      if (cls == null) {
        // eslint-disable-next-line no-console
        console.warn(`No client for "${className}", skipping`)
        continue
      }

      const { parameterSchema, responseObjType, responseArrType } =
        getParameterAndResponseSchema({ path: endpoint.path, post })

      if (parameterSchema == null) {
        // eslint-disable-next-line no-console
        console.warn(`No parameter schema for "${endpoint.path}", skipping`)
        continue
      }

      const methodName = post['x-fern-sdk-method-name'] ?? endpoint.name
      const returnResource = responseObjType ?? responseArrType

      cls.methods.push({
        methodName,
        path: endpoint.path,
        // TODO: Use endpoint.request.parameters from the blueprint once
        // generated output is allowed to change. The blueprint collapses
        // integer to number and flattens unions differently, so parameters are
        // derived from the raw OpenAPI schema for identical output.
        parameters: Object.entries(parameterSchema.properties)
          .filter(([, paramVal]) => 'type' in paramVal)
          .map(([paramName]) => ({
            name: paramName,
            required: parameterSchema.required?.includes(paramName),
            position:
              methodName === 'get' &&
              paramName === `${post['x-fern-sdk-return-value']}_id`
                ? 0
                : undefined,
          })),
        // TODO: Use endpoint.response.responseKey from the blueprint once
        // generated output is allowed to change.
        returnPath: post['x-fern-sdk-return-value'] ?? '',
        returnResource:
          returnResource != null
            ? pascalCase(convertCustomResourceName(returnResource))
            : null,
      })
    }
  }

  const clientNames: string[] = []
  for (const cls of clientMap.values()) {
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
    ...setRoutesFileLayoutContext(Object.keys(parentToChildResourcesMap)),
  }
}
