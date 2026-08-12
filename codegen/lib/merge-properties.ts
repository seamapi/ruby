import type { Property } from '@seamapi/blueprint'

const formatKey = (property: Property): string =>
  property.format === 'list' ? `list<${property.itemFormat}>` : property.format

const isScalar = (property: Property): boolean =>
  property.format !== 'list' && property.format !== 'object'

// The variants of a discriminated union collapse into a single class, so a
// property carried by more than one variant has to end up with every field any
// variant gives it. Keeping only the first occurrence silently drops the rest,
// which loses data once the merged shape is a typed class rather than a hash.
const mergeOccurrences = (occurrences: Property[], path: string): Property => {
  const [first, ...rest] = occurrences
  if (first == null) throw new Error(`Nothing to merge at ${path}.`)
  if (rest.length === 0) return first

  const formats = new Set(occurrences.map(formatKey))
  if (formats.size > 1) {
    // Scalars all become a plain accessor, so any of them represents the rest.
    if (occurrences.every(isScalar)) return first
    throw new Error(
      `Cannot merge ${path}: variants disagree on its shape (${[...formats].join(', ')}).`,
    )
  }

  if (first.format === 'object') {
    return {
      ...first,
      properties: mergeProperties(
        occurrences.map(
          (occurrence) => (occurrence as typeof first).properties,
        ),
        path,
      ),
    }
  }

  if (first.format === 'list' && first.itemFormat === 'object') {
    return {
      ...first,
      itemProperties: mergeProperties(
        occurrences.map(
          (occurrence) => (occurrence as typeof first).itemProperties,
        ),
        `${path}[]`,
      ),
    }
  }

  if (first.format === 'list' && first.itemFormat === 'discriminated_object') {
    // Keep every variant. Whoever consumes this list merges them in turn.
    return {
      ...first,
      variants: occurrences.flatMap(
        (occurrence) => (occurrence as typeof first).variants,
      ),
    }
  }

  return first
}

export const mergeProperties = (
  propertyLists: Property[][],
  path = '',
): Property[] => {
  const occurrences = new Map<string, Property[]>()
  for (const properties of propertyLists) {
    for (const property of properties) {
      const group = occurrences.get(property.name)
      if (group == null) {
        occurrences.set(property.name, [property])
      } else {
        group.push(property)
      }
    }
  }

  return [...occurrences.entries()]
    .map(([name, group]) =>
      mergeOccurrences(group, path === '' ? name : `${path}.${name}`),
    )
    .sort((a, b) => a.name.localeCompare(b.name))
}
