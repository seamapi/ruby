import { dirname, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'

import {
  generateRubySDK as generateSdk,
  writeFs,
} from '@seamapi/nextlove-sdk-generator'
import { openapi } from '@seamapi/types/connect'
import { deleteAsync } from 'del'

const rootPath = dirname(fileURLToPath(import.meta.url))
const outputPath = resolve(rootPath, 'lib', 'seam', 'routes')

await deleteAsync(outputPath)

const fileSystem = await generateSdk({
  openApiSpecObject: openapi,
})

writeFs(rootPath, fileSystem)
