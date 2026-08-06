import type { Property } from '@seamapi/blueprint'

export const mergeProperties = (propertyLists: Property[][]): Property[] => {
  const merged = new Map<string, Property>()
  for (const properties of propertyLists) {
    for (const property of properties) {
      if (!merged.has(property.name)) merged.set(property.name, property)
    }
  }
  return [...merged.values()].sort((a, b) => a.name.localeCompare(b.name))
}
