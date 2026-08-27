// Builds the template context for resource files
// (lib/seam/resources/{snake_name}.rb).

import type {
  ActionAttemptStatus,
  DiscriminatedListProperty,
  Property,
} from '@seamapi/blueprint'
import { pascalCase } from 'change-case'

import { convertCustomResourceName } from '../custom-resource-name-conversions.js'
import { mergeProperties } from '../merge-properties.js'

type ResourceAccessor = Property & Documented & { className: string }
type PropertyAccessor = Property &
  Documented & {
    accessorName: string
    isAliased: boolean
  }

export interface DiscriminatedVariantSource {
  discriminatorValue: string
  description: string
  properties: Property[]
}

interface ResourceVariant extends ResourceClass {
  discriminatorValue: string
}

export interface ResourceClass {
  className: string
  superclass: string
  description: string
  indentation: number
  indent: string
  bodyIndent: string
  docIndent: number
  accessors: PropertyAccessor[]
  dateAccessors: PropertyAccessor[]
  resourceAccessors: ResourceAccessor[]
  resourceListAccessors: ResourceAccessor[]
  nestedClasses: ResourceClass[]
  discriminator: string | null
  variants: ResourceVariant[]
}

export interface ResourceLayoutContext {
  className: string
  resource: Documented
  accessors: PropertyAccessor[]
  dateAccessors: PropertyAccessor[]
  nestedClasses: ResourceClass[]
  resourceAccessors: ResourceAccessor[]
  resourceListAccessors: ResourceAccessor[]
  discriminator: string | null
  variants: ResourceVariant[]
}

interface Documented {
  description: string
  isDeprecated: boolean
  deprecationMessage: string
}

interface DiscriminatedSource {
  discriminator: string
  variants: DiscriminatedVariantSource[]
}

// Resource classes open inside `module Seam; module Resources`.
const rootIndentation = 4

// Nested classes are named after their property, so an unusually deep shape is
// far more likely to be an accidental cycle than a real schema.
const maxNestingDepth = 16

// Constants a nested class must not shadow, since generated code resolves them
// from the enclosing lexical scope.
const reservedClassNames = new Set(['BaseResource', 'Resources', 'Seam'])

const isErrorOrWarningList = (
  property: Property,
): property is DiscriminatedListProperty =>
  property.format === 'list' &&
  property.itemFormat === 'discriminated_object' &&
  ['error_code', 'warning_code'].includes(property.discriminator)

export const sameDescription = (properties: Property[]): string => {
  const descriptions = new Set(properties.map(({ description }) => description))
  return descriptions.size === 1 ? (properties[0]?.description ?? '') : ''
}

// A fallback class only promises scalar fields every known variant carries.
// Variant-only and nested fields stay on their specific subclasses.
export const getCommonScalarProperties = (
  propertyLists: Property[][],
): Property[] => {
  const [first = []] = propertyLists
  const result: Property[] = []

  for (const property of first) {
    if (
      property.format === 'list' ||
      property.format === 'object' ||
      property.format === 'record'
    ) {
      continue
    }

    const occurrences = propertyLists.map((properties) =>
      properties.find(({ name }) => name === property.name),
    )
    if (
      occurrences.some(
        (occurrence) =>
          occurrence == null || occurrence.format !== property.format,
      )
    ) {
      continue
    }

    const present = occurrences as Property[]
    const docs = {
      description: sameDescription(present),
      isOptional: present.some(({ isOptional }) => isOptional),
      isNullable: present.some(({ isNullable }) => isNullable),
    }

    if (property.format === 'enum') {
      const values = new Map(
        present.flatMap((occurrence) =>
          occurrence.format === 'enum'
            ? occurrence.values.map((value) => [value.name, value] as const)
            : [],
        ),
      )
      result.push({ ...property, ...docs, values: [...values.values()] })
    } else if (property.format === 'boolean') {
      const booleans = present.filter(
        (occurrence): occurrence is Extract<Property, { format: 'boolean' }> =>
          occurrence.format === 'boolean',
      )
      const common = { ...property, ...docs }
      if (booleans.some(({ values }) => values == null)) {
        delete common.values
      } else {
        common.values = [
          ...new Set(booleans.flatMap(({ values }) => values ?? [])),
        ]
      }
      result.push(common)
    } else {
      result.push({ ...property, ...docs })
    }
  }

  return result
}

// An action-attempt property annotated with actionAttemptStatuses only holds a
// value for the listed statuses and is null for the others. An annotation that
// covers every known status is equivalent to no annotation at all.
const getScopedStatuses = (
  property: Property,
  allStatuses: string[] | undefined,
): ActionAttemptStatus[] | undefined => {
  const statuses: string[] | undefined = property.actionAttemptStatuses
  if (statuses == null || statuses.length === 0) return undefined
  if (allStatuses != null && allStatuses.every((s) => statuses.includes(s))) {
    return undefined
  }
  return property.actionAttemptStatuses
}

const getDiscriminatorValue = (
  properties: Property[],
  discriminator: string,
): string => {
  const property = properties.find(({ name }) => name === discriminator)
  const value = property?.format === 'enum' ? property.values[0]?.name : null
  if (value == null) {
    throw new Error(`Missing enum discriminator ${discriminator}.`)
  }
  return value
}

const getNestedProperties = (property: Property): Property[] | undefined => {
  if (property.format === 'object') return property.properties
  if (property.format === 'list' && property.itemFormat === 'object') {
    return property.itemProperties
  }
  if (
    property.format === 'list' &&
    property.itemFormat === 'discriminated_object'
  ) {
    if (['error_code', 'warning_code'].includes(property.discriminator)) {
      return getCommonScalarProperties(
        property.variants.map(({ properties }) => properties),
      )
    }
    return mergeProperties(
      property.variants.map((variant) => variant.properties),
    )
  }
  return undefined
}

const getVariantClassName = (value: string): string =>
  pascalCase(value).replaceAll(/_(?=\d)/g, 'N')

const addVariants = (
  resourceClass: ResourceClass,
  source: DiscriminatedSource,
  path: string,
): void => {
  const takenClassNames = new Set(
    resourceClass.nestedClasses.map(({ className }) => className),
  )

  resourceClass.discriminator = source.discriminator
  resourceClass.variants = source.variants.map((variant) => {
    const className = getVariantClassName(variant.discriminatorValue)
    if (reservedClassNames.has(className) || takenClassNames.has(className)) {
      throw new Error(
        `The variants at ${path} generate the duplicate or reserved class name ${className}.`,
      )
    }
    takenClassNames.add(className)

    return {
      ...buildClass(
        className,
        variant.properties,
        `${path}.${variant.discriminatorValue}`,
        resourceClass.indentation + 2,
        resourceClass.className,
        variant.description,
      ),
      discriminatorValue: variant.discriminatorValue,
    }
  })
}

const buildClass = (
  className: string,
  classProperties: Property[],
  path: string,
  indentation: number,
  superclass = 'BaseResource',
  description = '',
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

  // The status property enumerates every status the resource can be in, which
  // reveals when an actionAttemptStatuses annotation is actually restrictive.
  const statusProperty = classProperties.find(
    ({ name, format }) => name === 'status' && format === 'enum',
  )
  const allStatuses =
    statusProperty?.format === 'enum'
      ? statusProperty.values.map(({ name }) => name)
      : undefined

  const scopeToStatuses = <T extends Property>(property: T): T => {
    const statuses = getScopedStatuses(property, allStatuses)
    if (statuses == null) {
      if (property.actionAttemptStatuses == null) return property
      const unscoped = { ...property }
      delete unscoped.actionAttemptStatuses
      return unscoped
    }
    return { ...property, actionAttemptStatuses: statuses, isNullable: true }
  }

  for (const property of classProperties) {
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
    destination.push({
      ...scopeToStatuses(property),
      className: nestedClassName,
    })

    const discriminated = isErrorOrWarningList(property)
    const nestedClass = buildClass(
      nestedClassName,
      nestedProperties,
      nestedPath,
      indentation + 2,
      'BaseResource',
      discriminated
        ? `Known \`${property.discriminator}\` values load as subclasses; unknown values remain ${nestedClassName} instances for forward compatibility.`
        : '',
    )
    if (discriminated) {
      addVariants(
        nestedClass,
        {
          discriminator: property.discriminator,
          variants: property.variants.map((variant) => ({
            discriminatorValue: getDiscriminatorValue(
              variant.properties,
              property.discriminator,
            ),
            description: variant.description,
            properties: variant.properties,
          })),
        },
        nestedPath,
      )
    }
    nestedClasses.push(nestedClass)
  }

  const typedNames = new Set(
    [...resourceAccessors, ...resourceListAccessors].map(({ name }) => name),
  )
  const toPropertyAccessor = (property: Property): PropertyAccessor => {
    const isAliased = property.name === 'method' && path.startsWith('event.')
    return {
      ...scopeToStatuses(property),
      accessorName: isAliased ? 'event_method' : property.name,
      isAliased,
    }
  }

  return {
    className,
    superclass,
    description,
    indentation,
    indent: ' '.repeat(indentation),
    bodyIndent: ' '.repeat(indentation + 2),
    docIndent: indentation + 2,
    accessors: classProperties
      .filter(
        (property) =>
          property.format !== 'datetime' && !typedNames.has(property.name),
      )
      .map(toPropertyAccessor),
    dateAccessors: classProperties
      .filter((property) => property.format === 'datetime')
      .map(toPropertyAccessor),
    resourceAccessors,
    resourceListAccessors,
    nestedClasses,
    discriminator: null,
    variants: [],
  }
}

export const setResourceLayoutContext = (
  snakeName: string,
  properties: Property[],
  resource: Documented & Partial<DiscriminatedSource>,
): ResourceLayoutContext => {
  const className = pascalCase(convertCustomResourceName(snakeName))
  const rootClass = buildClass(
    className,
    properties,
    snakeName,
    rootIndentation,
  )
  if (resource.discriminator != null && resource.variants != null) {
    addVariants(
      rootClass,
      { discriminator: resource.discriminator, variants: resource.variants },
      snakeName,
    )
  }

  return {
    className,
    resource,
    accessors: rootClass.accessors,
    dateAccessors: rootClass.dateAccessors,
    nestedClasses: rootClass.nestedClasses,
    resourceAccessors: rootClass.resourceAccessors,
    resourceListAccessors: rootClass.resourceListAccessors,
    discriminator: rootClass.discriminator,
    variants: rootClass.variants,
  }
}
