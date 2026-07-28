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

export const rubyParamDoc = (
  parameter: Documented & { name: string },
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
      `@param ${parameter.name} ${firstLine}`.trimEnd(),
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
