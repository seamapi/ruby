// Builds the template context for the index files
// (lib/seam/routes/{clients,resources}/index.rb).
// Mirrors the output of the nextlove get-entity-imports-template.ts.

export interface ImportsLayoutContext {
  customImports: string[]
  requires: string[]
}

export const setImportsLayoutContext = (
  entityNames: string[],
  customImports: string[],
): ImportsLayoutContext => ({
  customImports,
  requires: entityNames,
})
