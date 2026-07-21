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

// Sorts parameters with an explicit position first, then required parameters,
// then optional parameters; the sort is stable within each tier.
export const sortClientMethodParameters = (
  parameters: ClientMethodParameter[],
): ClientMethodParameter[] =>
  [...parameters].sort(
    (a, b) =>
      (a.position ?? (a.required ?? false ? 1000 : 9999)) -
      (b.position ?? (b.required ?? false ? 1000 : 9999)),
  )
