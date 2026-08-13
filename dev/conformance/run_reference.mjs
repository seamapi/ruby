// Runs the TypeScript reference implementation over the conformance fixture,
// printing one line per case: the serialized query string, or !ERROR when the
// case throws UnserializableParamError. Compare byte for byte against the
// output of run_ruby.rb.
//
// Usage: node run_reference.mjs FIXTURE_PATH

import { readFileSync } from 'node:fs'

import {
  serializeUrlSearchParams,
  UnserializableParamError,
} from '@seamapi/url-search-params-serializer'

const revive = (value) => {
  if (value === null) return null
  if (Array.isArray(value)) return value.map(revive)
  if (typeof value === 'object') {
    if ('$float' in value) return Number(value.$float)
    if ('$bigint' in value) return BigInt(value.$bigint)
    if ('$date' in value) return new Date(value.$date)
    if ('$undefined' in value) return undefined
    return Object.fromEntries(
      Object.entries(value).map(([k, v]) => [k, revive(v)]),
    )
  }
  return value
}

const cases = JSON.parse(readFileSync(process.argv[2], 'utf8'))

const lines = cases.map((params) => {
  try {
    return serializeUrlSearchParams(revive(params))
  } catch (err) {
    if (err instanceof UnserializableParamError) return '!ERROR'
    throw err
  }
})

process.stdout.write(lines.join('\n') + '\n')
