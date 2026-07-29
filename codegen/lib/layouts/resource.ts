// Builds the template context for resource files
// (lib/seam/resources/{snake_name}.rb).

import type { Property } from '@seamapi/blueprint'
import { pascalCase } from 'change-case'

import { convertCustomResourceName } from '../custom-resource-name-conversions.js'

export interface ResourceLayoutContext {
  className: string
  resource: Documented
  accessors: Array<Property & Documented>
  dateAccessors: Array<Property & Documented>
  hasSupportModules: boolean
  includeErrorsSupport: boolean
  includeWarningsSupport: boolean
}

interface Documented {
  description: string
  isDeprecated: boolean
  deprecationMessage: string
}

export const setResourceLayoutContext = (
  snakeName: string,
  properties: Property[],
  resource: {
    description: string
    isDeprecated: boolean
    deprecationMessage: string
  },
): ResourceLayoutContext => {
  const attrs = properties
    .filter((property) => property.format !== 'datetime')
    .map((property) => property.name)
  const dateAttrs = properties
    .filter((property) => property.format === 'datetime')
    .map((property) => property.name)
  const noErrorWarningAttrs = attrs.filter(
    (attr) => attr !== 'errors' && attr !== 'warnings',
  )

  const includeErrorsSupport = attrs.includes('errors')
  const includeWarningsSupport = attrs.includes('warnings')

  return {
    className: pascalCase(convertCustomResourceName(snakeName)),
    resource,
    accessors: properties
      .filter((property) => noErrorWarningAttrs.includes(property.name))
      .map((property) => property),
    dateAccessors: properties
      .filter((property) => dateAttrs.includes(property.name))
      .map((property) => property),
    hasSupportModules: includeErrorsSupport || includeWarningsSupport,
    includeErrorsSupport,
    includeWarningsSupport,
  }
}
