// Builds the template context for lib/seam/routes/routes.rb.
// Mirrors the output of the nextlove routes.rb.template.ts.

import { pascalCase } from 'change-case'

export interface RoutesFileLayoutContext {
  routeClients: Array<{ name: string; className: string }>
}

export const setRoutesFileLayoutContext = (
  resourceClientNames: string[],
): RoutesFileLayoutContext => ({
  routeClients: resourceClientNames.map((name) => ({
    name,
    className: pascalCase(name),
  })),
})
