// Ported from @seamapi/nextlove-sdk-generator lib/generate-ruby-sdk/ruby-client.ts.
// Holds the data previously carried by the nextlove RubyClient; all string
// serialization moved to the Handlebars layouts and their context builders.

export interface ClientMethodParameter {
  name: string
  required?: boolean | undefined
  position?: number | undefined
}

export interface ClientMethod {
  methodName: string
  path: string
  parameters: ClientMethodParameter[]
  returnResource: string | null
  returnPath: string
}

export interface ChildClientIdentifier {
  clientName: string
  namespace: string
}

export interface ClientModel {
  name: string
  namespace: string
  methods: ClientMethod[]
  childClientIdentifiers: ChildClientIdentifier[]
}

// Verbatim port of the nextlove parameter comparator. The original expression
// `(a.position ?? a.required ? 1000 : 9999)` parses as
// `(a.position ?? a.required) ? 1000 : 9999`, so a parameter with position 0
// is falsy and lands in the 9999 tier together with the optional parameters.
// Combined with a stable sort this yields: required parameters first (in schema
// order), then everything else (in schema order).
// TODO: Fix the operator precedence so position sorts a parameter first as
// originally intended, once generated output is allowed to change. Until then,
// do not "fix" it: the generated output must stay identical.
export const sortClientMethodParameters = (
  parameters: ClientMethodParameter[],
): ClientMethodParameter[] =>
  [...parameters].sort(
    (a, b) =>
      (a.position ?? a.required ? 1000 : 9999) -
      (b.position ?? b.required ? 1000 : 9999),
  )
