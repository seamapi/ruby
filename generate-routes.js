import { dirname, posix } from 'node:path'
import { fileURLToPath } from 'node:url'

import {
  generateRubySDK as generateSdk,
  writeFs,
} from '@seamapi/nextlove-sdk-generator'
import { openapi } from '@seamapi/types/connect'
import { deleteAsync } from 'del'

const rootPath = dirname(fileURLToPath(import.meta.url))
const libName = 'lib'
const libPath = posix.join(rootPath, libName)
const seamName = 'seam'
const seamPath = posix.join(libPath, seamName)
const libVersionPath = posix.join(seamPath, 'version.rb')
const libVersionRelativePath = posix.join(libName, seamName, 'version.rb')

const pathsToDelete = [
  `${libPath}/**/*`,
  `!${libPath}/seam/`,
  `!${libVersionPath}`,
]

await deleteAsync(pathsToDelete)

const fileSystem = await generateSdk({
  openApiSpecObject: openapi,
})

const files = Object.entries(fileSystem)
  .filter(([fileName]) => fileName.startsWith(`${libName}/`))
  .filter(([fileName]) => !fileName.startsWith(libVersionRelativePath))
  .map(([fileName, fileContent]) =>
    fileName.startsWith('lib/seamapi.rb')
      ? ['lib/seam.rb', fileContent]
      : [fileName, fileContent],
  )

writeFs(rootPath, Object.fromEntries(files))
