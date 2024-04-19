import { dirname, posix, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'

import {
  generateRubySDK as generateSdk,
  writeFs,
} from '@seamapi/nextlove-sdk-generator'
import { openapi } from '@seamapi/types/connect'
import { deleteAsync } from 'del'

const libNameParts = ['lib', 'seam']
const libPrefix = posix.join(...libNameParts)
const libVersionPath = posix.join(libPrefix, 'version.rb')

const rootPath = dirname(fileURLToPath(import.meta.url))

// TODO: Enable later
// await deleteAsync([`${libPrefix}/**`, `!${libVersionPath}`])

const fileSystem = await generateSdk({
  openApiSpecObject: openapi,
})

const files = Object.entries(fileSystem)
  .filter(([fileName]) => fileName.startsWith(`${libPrefix}/`))
  .filter(([fileName]) => !fileName.startsWith(`${libPrefix}/version.rb`))

// TODO: Enable later
// writeFs(rootPath, Object.fromEntries(files))
