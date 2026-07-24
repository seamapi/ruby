import { dirname } from 'node:path'
import { fileURLToPath } from 'node:url'

import layouts from '@metalsmith/layouts'
import { createBlueprint, TypesModuleSchema } from '@seamapi/blueprint'
import { getHandlebarsPartials } from '@seamapi/smith'
import * as types from '@seamapi/types/connect'
import { deleteAsync } from 'del'
import Metalsmith from 'metalsmith'

import { helpers, routes } from './lib/index.js'

const rootDir = dirname(fileURLToPath(import.meta.url))

await Promise.all([deleteAsync('./lib/seam/routes')])

const partials = await getHandlebarsPartials(`${rootDir}/layouts/partials`)

// Build the blueprint with omitUndocumented so undocumented routes,
// namespaces, endpoints, parameters, resources, and properties are dropped
// before codegen runs. This replaces the @seamapi/smith blueprint plugin,
// which does not forward the omitUndocumented option to createBlueprint.
const setBlueprint = async (
  _files: Metalsmith.Files,
  metalsmith: Metalsmith,
): Promise<void> => {
  const typesModule = TypesModuleSchema.parse({
    ...types,
    codeSampleDefinitions: [],
    resourceSampleDefinitions: [],
  })
  const blueprint = await createBlueprint(typesModule, {
    omitUndocumented: true,
  })
  Object.assign(metalsmith.metadata(), { blueprint })
}

Metalsmith(rootDir)
  .source('./content')
  .destination('../')
  .clean(false)
  .use(setBlueprint)
  .use(routes)
  .use(
    layouts({
      default: 'default.hbs',
      engineOptions: {
        noEscape: true,
        helpers,
        partials,
      },
    }),
  )
  .build((err) => {
    if (err != null) throw err
  })
