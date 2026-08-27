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

export const rubyString = (value: string): string => JSON.stringify(value)

export const rubyEnumValuesDoc = (
  property: Property,
  indentation: number,
): string => {
  const values =
    property.format === 'enum'
      ? property.values
      : property.format === 'list' && property.itemFormat === 'enum'
        ? property.itemEnumValues
        : []
  return values.length === 0
    ? ''
    : `\n${comment(
        ['Known values:', ...values.map(({ name }) => `- \`${name}\``)],
        indentation,
      )}`
}

const humanizeList = (items: string[], conjunction: string): string => {
  if (items.length <= 1) return items[0] ?? ''
  if (items.length === 2) return items.join(` ${conjunction} `)
  return `${items.slice(0, -1).join(', ')}, ${conjunction} ${items.at(-1)}`
}

// Documents a property scoped to specific action-attempt statuses; a property
// without the annotation has the same value for every status.
export const rubyActionAttemptStatusesDoc = (
  property: Property,
  indentation: number,
): string => {
  const statuses = property.actionAttemptStatuses
  if (statuses == null || statuses.length === 0) return ''
  const list = humanizeList(
    statuses.map((status) => `\`${status}\``),
    'or',
  )
  return `\n${comment(
    [`Only present when \`status\` is ${list}; \`nil\` otherwise.`],
    indentation,
  )}`
}

export const rubyStringArray = (values: string[]): string =>
  `[${values.map((value) => JSON.stringify(value)).join(', ')}]`

const nullable = (
  type: string,
  value: { isOptional: boolean; isNullable: boolean },
): string => (value.isOptional || value.isNullable ? `${type}, nil` : type)

const jsonSchemaType = (type: string): string => {
  switch (type) {
    case 'string':
      return 'String'
    case 'number':
      return 'Float'
    case 'integer':
      return 'Integer'
    case 'boolean':
      return 'Boolean'
    case 'object':
      return 'Hash'
    case 'array':
      return 'Array'
    default:
      throw new Error(`Unsupported JSON Schema type: ${type}`)
  }
}

const scalarType = (
  format: string,
  isInt = false,
  booleanValues?: boolean[],
  recordValueTypes?: string[],
): string => {
  switch (format) {
    case 'boolean': {
      const values = [...new Set(booleanValues)]
      return values.length === 1
        ? values[0]
          ? 'TrueClass'
          : 'FalseClass'
        : 'Boolean'
    }
    case 'number':
      return isInt ? 'Integer' : 'Float'
    case 'datetime':
      return 'Time'
    case 'id':
    case 'string':
    case 'enum':
      return 'String'
    case 'record':
      return recordValueTypes == null || recordValueTypes.length === 0
        ? 'Hash'
        : `Hash{String => ${recordValueTypes.map(jsonSchemaType).join(', ')}}`
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
          property.format === 'boolean' ? property.values : undefined,
          property.format === 'record' && 'valueTypes' in property
            ? property.valueTypes
            : undefined,
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
          parameter.format === 'boolean' ? parameter.values : undefined,
          parameter.format === 'record' ? parameter.valueTypes : undefined,
        )
  // Only a nullable parameter accepts the Seam::NULL sentinel, and only an
  // optional parameter accepts nil.
  const union = [type]
  if (parameter.isNullable) union.push('Seam::Null')
  if (!parameter.isRequired) union.push('nil')
  return union.join(', ')
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
