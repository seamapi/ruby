// Builds the template context for resource files
// (lib/seam/routes/resources/{snake_name}.rb).
// Mirrors the output of the nextlove resource.rb.template.ts.

import { pascalCase } from 'change-case'

import { convertCustomResourceName } from '../custom-resource-name-conversions.js'
import { flattenObjSchema } from '../openapi/flatten-obj-schema.js'
import type { ObjSchema } from '../openapi/types.js'

export interface ResourceLayoutContext {
  className: string
  attrAccessors: string
  hasDateAccessors: boolean
  dateAccessors: string
  hasSupportModules: boolean
  includeErrorsSupport: boolean
  includeWarningsSupport: boolean
}

export const setResourceLayoutContext = (
  snakeName: string,
  schema: ObjSchema,
): ResourceLayoutContext => {
  // TODO: Use resource properties from @seamapi/blueprint once generated output
  // is allowed to change. Blueprint omits some schemas, reorders others, and
  // collapses integer to number, so the raw OpenAPI schema is used here to keep
  // the output identical.
  const properties = Object.entries(flattenObjSchema(schema).properties).map(
    ([name, propertySchema]) => ({
      name,
      isDateTime:
        'format' in propertySchema && propertySchema.format === 'date-time',
    }),
  )

  const attrs = properties.filter((p) => !p.isDateTime).map((p) => p.name)
  const dateAttrs = properties.filter((p) => p.isDateTime).map((p) => p.name)
  const noErrorWarningAttrs = attrs.filter(
    (attr) => attr !== 'errors' && attr !== 'warnings',
  )

  const includeErrorsSupport = attrs.includes('errors')
  const includeWarningsSupport = attrs.includes('warnings')

  return {
    className: pascalCase(convertCustomResourceName(snakeName)),
    attrAccessors: noErrorWarningAttrs.map((attr) => `:${attr}`).join(', '),
    hasDateAccessors: dateAttrs.length > 0,
    dateAccessors: dateAttrs.map((attr) => `:${attr}`).join(', '),
    hasSupportModules: includeErrorsSupport || includeWarningsSupport,
    includeErrorsSupport,
    includeWarningsSupport,
  }
}
