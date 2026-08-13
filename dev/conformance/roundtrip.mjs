// Feeds the Ruby serializer's output back through
// @seamapi/url-search-params-parser in strict mode and asserts the parsed
// structure matches the fixture input. Matching the reference byte for byte
// is the strong property; round-tripping proves both sides agree on what the
// string means.
//
// Cases are skipped when the parser cannot express them: error cases (the
// serializer rejected the input), boolean or mixed-type arrays, and integers
// beyond Number.MAX_SAFE_INTEGER.
//
// Usage: node roundtrip.mjs FIXTURE_PATH RUBY_OUTPUT_PATH

import { readFileSync } from 'node:fs'

import { parseUrlSearchParams } from '@seamapi/url-search-params-parser'
import { z } from 'zod'

const SKIP = Symbol('skip')

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

// Returns { schema, expected } for a revived params object, or SKIP when the
// parser cannot express the case.
const planFor = (value) => {
  if (value === null) {
    return { schema: z.string().nullable(), expected: null }
  }
  if (typeof value === 'string') {
    return value === '' ? SKIP : { schema: z.string(), expected: value }
  }
  if (typeof value === 'number') {
    if (!Number.isFinite(value)) return SKIP
    return { schema: z.number(), expected: Object.is(value, -0) ? 0 : value }
  }
  if (typeof value === 'bigint') {
    if (value > BigInt(Number.MAX_SAFE_INTEGER)) return SKIP
    if (value < -BigInt(Number.MAX_SAFE_INTEGER)) return SKIP
    return { schema: z.number(), expected: Number(value) }
  }
  if (typeof value === 'boolean') {
    return { schema: z.boolean(), expected: value }
  }
  if (value instanceof Date) {
    return { schema: z.date(), expected: value }
  }
  if (Array.isArray(value)) {
    if (value.length === 0) {
      return { schema: z.array(z.string()), expected: [] }
    }
    const plans = value.map(planFor)
    if (plans.some((p) => p === SKIP)) return SKIP
    const first = value[0]
    const uniform = (check) => value.every(check)
    if (typeof first === 'string' && uniform((v) => typeof v === 'string')) {
      return { schema: z.array(z.string()), expected: value }
    }
    if (
      (typeof first === 'number' || typeof first === 'bigint') &&
      uniform((v) => typeof v === 'number' || typeof v === 'bigint')
    ) {
      return {
        schema: z.array(z.number()),
        expected: plans.map((p) => p.expected),
      }
    }
    if (first instanceof Date && uniform((v) => v instanceof Date)) {
      return { schema: z.array(z.date()), expected: value }
    }
    // The parser has no boolean or mixed-type array schemas.
    return SKIP
  }
  if (typeof value === 'object') {
    const shape = {}
    const expected = {}
    for (const [key, element] of Object.entries(value)) {
      if (element === undefined) continue
      const plan = planFor(element)
      if (plan === SKIP) return SKIP
      shape[key] = plan.schema
      expected[key] = plan.expected
    }
    return { schema: z.object(shape), expected }
  }
  return SKIP
}

const equal = (actual, expected) => {
  if (expected instanceof Date) {
    return actual instanceof Date && actual.getTime() === expected.getTime()
  }
  if (Array.isArray(expected)) {
    return (
      Array.isArray(actual) &&
      actual.length === expected.length &&
      expected.every((element, i) => equal(actual[i], element))
    )
  }
  if (expected !== null && typeof expected === 'object') {
    if (actual === null || typeof actual !== 'object') return false
    const actualKeys = Object.keys(actual)
    const expectedKeys = Object.keys(expected)
    if (actualKeys.length !== expectedKeys.length) return false
    return expectedKeys.every((key) => equal(actual[key], expected[key]))
  }
  return Object.is(actual, expected)
}

const cases = JSON.parse(readFileSync(process.argv[2], 'utf8'))
const lines = readFileSync(process.argv[3], 'utf8').split('\n')

let checked = 0
let skipped = 0
let failures = 0

cases.forEach((params, i) => {
  const line = lines[i]
  if (line === '!ERROR') {
    skipped += 1
    return
  }
  const plan = planFor(revive(params))
  if (plan === SKIP) {
    skipped += 1
    return
  }
  let parsed
  try {
    parsed = parseUrlSearchParams(line, plan.schema, { strict: true })
  } catch (err) {
    failures += 1
    console.error(`case ${i}: parser rejected ${JSON.stringify(line)}: ${err}`)
    return
  }
  if (equal(parsed, plan.expected)) {
    checked += 1
  } else {
    failures += 1
    console.error(
      `case ${i}: mismatch for ${JSON.stringify(line)}\n  parsed:   ${JSON.stringify(parsed)}\n  expected: ${JSON.stringify(plan.expected)}`,
    )
  }
})

console.log(
  `Round trip: ${checked} matched, ${skipped} skipped (errors or unparseable types), ${failures} failed of ${cases.length} cases`,
)

if (failures > 0) process.exit(1)
