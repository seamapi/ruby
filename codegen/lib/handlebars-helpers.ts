import type { Parameter, Property } from '@seamapi/blueprint'

export const identity = (x: unknown): unknown => x

export interface Documented {
  description: string
  isDeprecated: boolean
  deprecationMessage: string
}

const comment = (lines: string[], indentation: number): string => {
  const prefix = `${' '.repeat(indentation)}#`
  return lines
    .map((line) => `${prefix}${line === '' ? '' : ` ${line}`}`)
    .join('\n')
}

export const rubyDoc = (description: string, indentation: number): string =>
  comment(description === '' ? [] : description.split('\n'), indentation)

export const rubyDeprecatedDoc = (
  documented: Documented,
  indentation: number,
): string =>
  documented.isDeprecated
    ? comment(
        [`@deprecated ${documented.deprecationMessage}`.trimEnd()],
        indentation,
      )
    : ''

const nullable = (
  type: string,
  value: { isOptional: boolean; isNullable: boolean },
): string => (value.isOptional || value.isNullable ? `${type}, nil` : type)

const scalarType = (format: string, isInt = false): string => {
  switch (format) {
    case 'boolean':
      return 'Boolean'
    case 'number':
      return isInt ? 'Integer' : 'Float'
    case 'datetime':
      return 'Time'
    case 'id':
    case 'string':
    case 'enum':
      return 'String'
    case 'record':
    case 'object':
      return 'Hash'
    default:
      return 'Object'
  }
}

export const rubyPropertyType = (property: Property): string => {
  const type =
    property.format === 'list'
      ? `Array<${scalarType(property.itemFormat, property.itemFormat === 'number' && property.isItemInt)}>`
      : scalarType(
          property.format,
          property.format === 'number' && property.isInt,
        )
  // BaseResource normalizes response lists to [] even when the API sends nil.
  return nullable(
    type,
    property.format === 'list'
      ? { ...property, isOptional: false, isNullable: false }
      : property,
  )
}

export const rubyResourceType = (
  property: Property & { className: string },
): string => {
  const type =
    property.format === 'list'
      ? `Array<${property.className}>`
      : property.className
  return nullable(
    type,
    property.format === 'list'
      ? { ...property, isOptional: false, isNullable: false }
      : property,
  )
}

export const rubyParameterType = (parameter: Parameter): string => {
  const type =
    parameter.format === 'list'
      ? `Array<${scalarType(parameter.itemFormat, parameter.itemFormat === 'number' && parameter.isItemInt)}>`
      : scalarType(
          parameter.format,
          parameter.format === 'number' && parameter.isInt,
        )
  return nullable(type, {
    isOptional: !parameter.isRequired,
    isNullable: parameter.isNullable,
  })
}

export const rubyParamDoc = (
  parameter: Documented & { name: string; rubyType?: string },
  indentation: number,
): string => {
  const [firstLine = '', ...remainingLines] = parameter.description.split('\n')
  const deprecation = parameter.isDeprecated
    ? [
        `@deprecated ${parameter.name}: ${parameter.deprecationMessage}`.trimEnd(),
      ]
    : []
  return comment(
    [
      `@param ${parameter.name}${parameter.rubyType == null ? '' : ` [${parameter.rubyType}]`} ${firstLine}`.trimEnd(),
      ...remainingLines,
      ...deprecation,
    ],
    indentation,
  )
}

export const rubyReturnDoc = (
  resource: string,
  description: string,
  indentation: number,
): string => {
  const [firstLine = '', ...remainingLines] = description.split('\n')
  return comment(
    [
      `@return [${resource === '' ? 'nil' : `Seam::Resources::${resource}`}] ${firstLine}`.trimEnd(),
      ...remainingLines,
    ],
    indentation,
  )
}
