// Builds the template context for resource files
// (lib/seam/routes/resources/{snake_name}.rb).

import type { Property } from '@seamapi/blueprint'
import { pascalCase } from 'change-case'

import { convertCustomResourceName } from '../custom-resource-name-conversions.js'

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
  properties: Property[],
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
    attrAccessors: noErrorWarningAttrs.map((attr) => `:${attr}`).join(', '),
    hasDateAccessors: dateAttrs.length > 0,
    dateAccessors: dateAttrs.map((attr) => `:${attr}`).join(', '),
    hasSupportModules: includeErrorsSupport || includeWarningsSupport,
    includeErrorsSupport,
    includeWarningsSupport,
  }
}
