// Builds the template context for resource files
// (lib/seam/resources/{snake_name}.rb).

import type { Property } from '@seamapi/blueprint'
import { pascalCase } from 'change-case'

import { convertCustomResourceName } from '../custom-resource-name-conversions.js'
import { mergeProperties } from '../merge-properties.js'

type ResourceAccessor = Property & Documented & { className: string }

export interface ResourceClass {
  className: string
  indent: string
  bodyIndent: string
  docIndent: number
  accessors: Array<Property & Documented>
  dateAccessors: Array<Property & Documented>
  resourceAccessors: ResourceAccessor[]
  resourceListAccessors: ResourceAccessor[]
  nestedClasses: ResourceClass[]
}

export interface ResourceLayoutContext {
  className: string
  resource: Documented
  accessors: Array<Property & Documented>
  dateAccessors: Array<Property & Documented>
  hasSupportModules: boolean
  includeErrorsSupport: boolean
  includeWarningsSupport: boolean
  nestedClasses: ResourceClass[]
  resourceAccessors: ResourceAccessor[]
  resourceListAccessors: ResourceAccessor[]
}

interface Documented {
  description: string
  isDeprecated: boolean
  deprecationMessage: string
}

// Resource classes open inside `module Seam; module Resources`.
const rootIndentation = 4

// Nested classes are named after their property, so an unusually deep shape is
// far more likely to be an accidental cycle than a real schema.
const maxNestingDepth = 16

// Constants a nested class must not shadow, since generated code resolves them
// from the enclosing lexical scope.
const reservedClassNames = new Set(['BaseResource', 'Resources', 'Seam'])

const getNestedProperties = (property: Property): Property[] | undefined => {
  if (property.format === 'object') return property.properties
  if (property.format === 'list' && property.itemFormat === 'object') {
    return property.itemProperties
  }
  if (
    property.format === 'list' &&
    property.itemFormat === 'discriminated_object'
  ) {
    return mergeProperties(
      property.variants.map((variant) => variant.properties),
    )
  }
  return undefined
}

const buildClass = (
  className: string,
  classProperties: Property[],
  path: string,
  indentation: number,
): ResourceClass => {
  if (indentation > rootIndentation + 2 * maxNestingDepth) {
    throw new Error(
      `Nested resource classes exceeded a depth of ${maxNestingDepth} at ${path}. This usually means the schema is cyclic.`,
    )
  }

  const nestedClasses: ResourceClass[] = []
  const resourceAccessors: ResourceAccessor[] = []
  const resourceListAccessors: ResourceAccessor[] = []
  const takenClassNames = new Set<string>()

  for (const property of classProperties) {
    // Errors and warnings are provided by the resource support modules.
    if (property.name === 'errors' || property.name === 'warnings') continue

    const nestedProperties = getNestedProperties(property)
    if (nestedProperties == null) continue

    // Each class scopes its own nested classes, so the property name alone
    // names them unambiguously.
    const nestedClassName = pascalCase(property.name)
    const nestedPath = `${path}.${property.name}`

    if (reservedClassNames.has(nestedClassName)) {
      throw new Error(
        `The ${nestedPath} property would generate a nested class named ${nestedClassName}, which shadows a constant the generated code depends on.`,
      )
    }

    if (takenClassNames.has(nestedClassName)) {
      throw new Error(
        `The ${nestedPath} property would generate a second nested class named ${nestedClassName} inside ${className}.`,
      )
    }
    takenClassNames.add(nestedClassName)

    const destination =
      property.format === 'list' ? resourceListAccessors : resourceAccessors
    destination.push({ ...property, className: nestedClassName })
    nestedClasses.push(
      buildClass(
        nestedClassName,
        nestedProperties,
        nestedPath,
        indentation + 2,
      ),
    )
  }

  const typedNames = new Set(
    [...resourceAccessors, ...resourceListAccessors].map(({ name }) => name),
  )

  return {
    className,
    indent: ' '.repeat(indentation),
    bodyIndent: ' '.repeat(indentation + 2),
    docIndent: indentation + 2,
    accessors: classProperties.filter(
      (property) =>
        property.format !== 'datetime' && !typedNames.has(property.name),
    ),
    dateAccessors: classProperties.filter(
      (property) => property.format === 'datetime',
    ),
    resourceAccessors,
    resourceListAccessors,
    nestedClasses,
  }
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
  const attrs = properties.map((property) => property.name)
  const includeErrorsSupport = attrs.includes('errors')
  const includeWarningsSupport = attrs.includes('warnings')

  const className = pascalCase(convertCustomResourceName(snakeName))
  const rootClass = buildClass(
    className,
    properties,
    snakeName,
    rootIndentation,
  )

  return {
    className,
    resource,
    accessors: rootClass.accessors.filter(
      (property) => property.name !== 'errors' && property.name !== 'warnings',
    ),
    dateAccessors: rootClass.dateAccessors,
    hasSupportModules: includeErrorsSupport || includeWarningsSupport,
    includeErrorsSupport,
    includeWarningsSupport,
    nestedClasses: rootClass.nestedClasses,
    resourceAccessors: rootClass.resourceAccessors,
    resourceListAccessors: rootClass.resourceListAccessors,
  }
}
