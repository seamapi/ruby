// Builds the template context for client files
// (lib/seam/routes/clients/{snake_name}.rb).
// Mirrors the output of the nextlove RubyClient#serialize.

import { endpointsReturningDeprecatedActionAttempt } from '../endpoint-rules.js'
import {
  type ClientMethod,
  type ClientModel,
  sortClientMethodParameters,
} from '../ruby-client.js'

export interface ClientMethodLayoutContext {
  name: string
  hasSignature: boolean
  signatureParams: string
  hasParams: boolean
  bodyParams: string
  path: string
  usesRes: boolean
  isResource: boolean
  isPoll: boolean
  isNil: boolean
  returnResource: string
  returnPath: string
}

export interface ClientLayoutContext {
  className: string
  importActionAttempt: boolean
  childClients: Array<{ namespace: string; clientName: string }>
  methods: ClientMethodLayoutContext[]
}

const getMethodLayoutContext = (
  method: ClientMethod,
): ClientMethodLayoutContext => {
  const { methodName, path, parameters, returnResource, returnPath } = method

  const hasReturnValue = returnResource != null && returnPath !== ''
  const returnsDeprecatedActionAttempt =
    endpointsReturningDeprecatedActionAttempt.includes(path)
  const canPollActionAttempt =
    returnPath === 'action_attempt' && !returnsDeprecatedActionAttempt
  const hasParams = parameters.length > 0

  const sortedParameters = sortClientMethodParameters(parameters)

  const signatureParams = sortedParameters
    .map((p) => `${p.name}${p.required ?? false ? ':' : ': nil'}`)
    .concat(canPollActionAttempt ? ['wait_for_action_attempt: nil'] : [])
    .join(', ')

  const bodyParams = `{${sortedParameters
    .map((p) => `${p.name}: ${p.name}`)
    .join(', ')}}`

  // These three branches mirror the nextlove serializer and are independent by
  // design, not mutually exclusive: the resource line renders when there is a
  // return value that is not polled, and the nil line renders when there is no
  // return value or the endpoint returns a deprecated action attempt.
  const isResource = hasReturnValue && !canPollActionAttempt
  const isPoll = canPollActionAttempt
  const isNil = !hasReturnValue || returnsDeprecatedActionAttempt

  return {
    name: methodName,
    hasSignature: signatureParams.length > 0,
    signatureParams,
    hasParams,
    bodyParams,
    path,
    usesRes: isResource || isPoll,
    isResource,
    isPoll,
    isNil,
    returnResource: returnResource ?? '',
    returnPath,
  }
}

export const setClientLayoutContext = (
  cls: ClientModel,
): ClientLayoutContext => ({
  className: cls.name,
  importActionAttempt: cls.methods.some(
    ({ returnResource }) => returnResource === 'ActionAttempt',
  ),
  childClients: cls.childClientIdentifiers.map((i) => ({
    namespace: i.namespace,
    clientName: i.clientName,
  })),
  methods: cls.methods.map(getMethodLayoutContext),
})
