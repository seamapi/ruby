// Builds the template context for resource files
// (lib/seam/resources/{snake_name}.rb).

import type { Property } from '@seamapi/blueprint'
import { pascalCase } from 'change-case'

import { convertCustomResourceName } from '../custom-resource-name-conversions.js'
import { mergeProperties } from '../merge-properties.js'

type ResourceAccessor = Property & Documented & { className: string }

interface NestedClass {
  className: string
  accessors: Array<Property & Documented>
  dateAccessors: Array<Property & Documented>
  resourceAccessors: ResourceAccessor[]
  resourceListAccessors: ResourceAccessor[]
}

export interface ResourceLayoutContext {
  className: string
  resource: Documented
  accessors: Array<Property & Documented>
  dateAccessors: Array<Property & Documented>
  hasSupportModules: boolean
  includeErrorsSupport: boolean
  includeWarningsSupport: boolean
  nestedClasses: NestedClass[]
  resourceAccessors: ResourceAccessor[]
  resourceListAccessors: ResourceAccessor[]
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

  const rootClassName = pascalCase(convertCustomResourceName(snakeName))
  const nestedClasses = new Map<string, NestedClass>()

  const buildClass = (
    className: string,
    classProperties: Property[],
  ): NestedClass => {
    const resourceAccessors: ResourceAccessor[] = []
    const resourceListAccessors: ResourceAccessor[] = []

    for (const property of classProperties) {
      if (property.name === 'errors' || property.name === 'warnings') continue

      let nestedProperties: Property[] | undefined
      let destination = resourceAccessors
      if (property.format === 'object') {
        nestedProperties = property.properties
      } else if (
        property.format === 'list' &&
        property.itemFormat === 'object'
      ) {
        nestedProperties = property.itemProperties
        destination = resourceListAccessors
      } else if (
        property.format === 'list' &&
        property.itemFormat === 'discriminated_object'
      ) {
        nestedProperties = mergeProperties(
          property.variants.map((variant) => variant.properties),
        )
        destination = resourceListAccessors
      }

      if (nestedProperties == null) continue
      const nestedClassName = `${rootClassName}${pascalCase(property.name)}`
      destination.push({ ...property, className: nestedClassName })
      if (!nestedClasses.has(nestedClassName)) {
        const nestedClass = buildClass(nestedClassName, nestedProperties)
        nestedClasses.set(nestedClassName, nestedClass)
      }
    }

    const typedNames = new Set(
      [...resourceAccessors, ...resourceListAccessors].map(({ name }) => name),
    )
    return {
      className,
      accessors: classProperties.filter(
        (property) =>
          property.format !== 'datetime' && !typedNames.has(property.name),
      ),
      dateAccessors: classProperties.filter(
        (property) => property.format === 'datetime',
      ),
      resourceAccessors,
      resourceListAccessors,
    }
  }

  const parentClass = buildClass(rootClassName, properties)
  const parentTypedNames = new Set(
    [
      ...parentClass.resourceAccessors,
      ...parentClass.resourceListAccessors,
    ].map(({ name }) => name),
  )

  return {
    className: rootClassName,
    resource,
    accessors: properties
      .filter(
        (property) =>
          noErrorWarningAttrs.includes(property.name) &&
          !parentTypedNames.has(property.name),
      )
      .map((property) => property),
    dateAccessors: properties
      .filter((property) => dateAttrs.includes(property.name))
      .map((property) => property),
    hasSupportModules: includeErrorsSupport || includeWarningsSupport,
    includeErrorsSupport,
    includeWarningsSupport,
    nestedClasses: [...nestedClasses.values()],
    resourceAccessors: parentClass.resourceAccessors,
    resourceListAccessors: parentClass.resourceListAccessors,
  }
}
