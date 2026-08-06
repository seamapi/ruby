# Fix nested resource access in the Ruby SDK

## Task

Three separable problems, ordered by severity. **P1 is a live bug that returns a
wrong answer and should land on its own.** P2 is the nested types/docs parity
work. P3 is a design decision, not a defect.

Ruby is in a more defensible position than the Python SDK — it ships no RBS, no
sorbet, no `.rbi`, so unlike Python it never _claims_ a type it then violates.
Top-level properties are genuinely well documented via YARD comments on each
`attr_accessor`. The gaps below are about nested shapes and a handful of real
bugs.

---

## Where the code lives — read before editing

The generated/hand-written boundary is not obvious and `.gitattributes` only
covers part of it:

```
lib/seam/resources/** linguist-generated
lib/seam/routes/**    linguist-generated
```

| File                                                                                                                        | Status                                                                                                                                               |
| --------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `lib/seam/base_resource.rb`                                                                                                 | **hand-written** — edit directly                                                                                                                     |
| `lib/seam/deep_hash_accessor.rb`                                                                                            | **hand-written** — edit directly                                                                                                                     |
| `lib/seam/resources/*.rb` (Device, AccessCode, …)                                                                           | generated from `codegen/layouts/resource.hbs`                                                                                                        |
| `lib/seam/resources/resource_error.rb`, `resource_warning.rb`, `resource_errors_support.rb`, `resource_warnings_support.rb` | **generated from TypeScript string literals** in `codegen/lib/static-resources.ts` — _not_ from a `.hbs` template. Editing the `.rb` will not stick. |

Template context is built in `codegen/lib/layouts/resource.ts`. Regenerate with
`npm run generate` (`postgenerate` runs `rake format` → `standard:fix`).

---

## P1 — `DeepHashAccessor#[]` returns `nil` for every key

**A silently wrong answer, not an error.** Verified by running it:

```
method access:  true      # a.locked
bracket access: nil       # a["locked"]   ← wrong, and no exception
nested method:  1         # a.nested.x
missing key:    NoMethodError
identity stable? false    # a.nested.equal?(a.nested)
```

`lib/seam/deep_hash_accessor.rb`:

```ruby
def [](key)
  instance_variable_get(:"@#{key}")
end
```

`initialize` only ever sets `@data`. The per-key values live in singleton-method
closures created by `create_accessor_methods`, never in instance variables. So
every subscript lookup misses and returns `nil`.

This is untested — `lib/seam/deep_hash_accessor_spec.rb` covers method access,
nested access, arrays, and `NoMethodError` on missing keys, but never `#[]`.

**Fix**: delegate to the singleton methods so the two access styles cannot
diverge, and accept both string and symbol keys (Faraday's `:json` response
middleware produces string keys, while the specs construct with symbol keys):

```ruby
def [](key)
  name = key.to_s
  return nil unless respond_to?(name)
  public_send(name)
end
```

Returning `nil` for an unknown key (rather than raising) is the right call here —
it keeps `#[]` Hash-like, while `.key` keeps raising `NoMethodError`. Document
that asymmetry.

### P1b — values are re-allocated on every access

`process_value` runs _inside_ the singleton method body, so each call rebuilds the
`DeepHashAccessor` tree. Hence `a.nested.equal?(a.nested)` is `false`, and deep
access in a loop re-allocates every time.

**Fix**: compute once at construction:

```ruby
def create_accessor_methods
  @data.each do |key, value|
    processed = process_value(value)
    define_singleton_method(key) { processed }
  end
end
```

This makes construction eagerly recursive. Payload depth is small and bounded and
`process_value` cannot raise, so this is safe. If eager allocation is a concern,
memoize lazily into a hash instead.

### P1c — a response key that isn't a valid ivar name crashes deserialization

`BaseResource#process_data_attributes` does
`instance_variable_set(:"@#{key}", value)`. Verified:

```
exotic key: NameError: `@has-dash' is not allowed as an instance variable
```

So a single API response key containing a dash (or leading digit, or non-ASCII)
aborts the entire resource construction. Skip or sanitize keys that fail
`/\A[a-zA-Z_][a-zA-Z0-9_]*\z/` rather than raising. Also
`load_from_response(nil)` raises `NoMethodError` on `nil.each` — guard it and
return `nil`.

### P1d — memoized `errors` go stale after `update_from_response`

`resource_errors_support.rb` memoizes with `||=`:

```ruby
def errors
  @errors_converted ||= @errors.is_a?(Array) ? Seam::Resources::ResourceError.load_from_response(@errors) : []
end
```

`update_from_response` resets `@data` and re-runs `process_data_attributes`, but
never clears `@errors_converted`. Verified:

```
before: ["first"]
after:  ["first"]   <- expected ["second"]
raw @errors is correct: [{"error_code"=>"second"}]
```

**This is currently latent, not live** — `update_from_response` is only called
from `lib/seam/helpers/action_attempt.rb:42`, and `ActionAttempt` does not include
the support modules (it has a singular `error`, not `errors`). It becomes a real
bug the moment anything calls `update_from_response` on a resource that does
include them, or action attempts gain an `errors` property.

**Fix**: clear `@errors_converted` / `@warnings_converted` in
`update_from_response`. Because these files are emitted from
`codegen/lib/static-resources.ts`, the fix goes in the TS string literals.

---

## P2 — nested shapes have no types, docs, or autocomplete

`DeepHashAccessor` builds its accessors at runtime with `define_singleton_method`
from whatever keys happen to be in the payload. Nothing static can know that
`device.properties.locked` exists, so there is no YARD documentation and no editor
completion for any nested property.

The generated resource files confirm there is zero structural knowledge of nested
shapes. In all of `lib/seam/resources/device.rb`, the only mention of a nested
field name is incidental prose in a _different_ property's comment:

```ruby
# Display name of the device, defaults to nickname (if it is set) or
# `properties.appearance.name`, otherwise.
```

### Approach

Mirror the PHP SDK — the only Seam SDK where the known-property guarantee holds at
depth — by generating a `BaseResource` subclass per nested object.

Blueprint already exposes the nested shape (the `javascript-http` templates
consume `properties`, `itemProperties`, and `variants` today), so **no
`@seamapi/blueprint` change is needed**.

1. **`codegen/lib/layouts/resource.ts`** — currently splits properties into
   `accessors` and `dateAccessors` and never recurses. Add a nested-class registry
   discovered while walking properties:
   - `format: 'object'` → nested class from `property.properties`
   - `format: 'list'` + `itemFormat: 'object'` → nested class from `property.itemProperties`
   - `format: 'list'` + `itemFormat: 'discriminated_object'` → merge `variants`,
     reusing the existing `mergeProperties` helper in `codegen/lib/routes.ts`
   - `format: 'record'` → **leave alone.** Genuinely free-form JSON
     (`custom_metadata`) must keep falling through to `DeepHashAccessor`.

   Name them `{ResourceClass}{PascalCaseProperty}` as PHP does — `DeviceProperties`,
   `DeviceAppearance` — and dedupe by class name.

2. **Add a class-level DSL to `BaseResource`**, mirroring the existing
   `date_accessor` pattern so the codegen stays declarative:

   ```ruby
   resource_accessor :properties, DeviceProperties
   resource_list_accessor :available_climate_presets, DeviceAvailableClimatePresets
   ```

   `process_hash_value` remains the fallback for anything without a declared
   class, so `record` properties are unaffected.

3. **`codegen/layouts/resource.hbs`** — emit nested classes alongside the parent
   with their own YARD doc comments, `attr_accessor` list, and `date_accessor`
   list. Nested classes must be defined **before** the parent references them.
   The generated docs are the actual user-facing win here.

4. **Leave `errors`/`warnings` on the existing support modules for now.** They
   already provide attribute access (`device.errors.first.error_code`) and `Time`
   parsing, which is the goal, and their shapes are hand-specified in
   `static-resources.ts`. Converting them to generated nested classes is a
   redundancy worth cleaning up separately — not worth the risk in this change.

### Behavior changes to document

- A typo'd nested attribute already raises `NoMethodError` today, so unlike the
  Python equivalent this change does **not** alter failure behavior for missing
  keys. Good.
- `device.properties` stops being a `DeepHashAccessor`. Anything relying on
  `is_a?(Seam::DeepHashAccessor)` breaks. Since `#[]` is broken today (P1),
  nobody can be relying on subscript access working — but once P1 lands, keep
  `#[]` working on the new nested classes too.
- **Empty-hash inconsistency, pre-existing**: `process_hash_value` guards with
  `value.is_a?(Hash) && !value.empty?`, so `device.properties` is a
  `DeepHashAccessor` normally but a bare `{}` when the API returns an empty
  object — callers must handle both shapes today. Asserted in
  `spec/resources/deep_hash_accessor_spec.rb`. Generated nested classes fix this
  incidentally; make sure the spec is updated rather than deleted.

---

## P3 — Ruby does no stripping at all (decision, not a defect)

`BaseResource` is **response-authoritative**: it iterates the payload, not the
schema.

```ruby
def process_data_attributes(data)
  data.each do |key, value|                    # iterates the RESPONSE
    value = process_hash_value(value)
    instance_variable_set(:"@#{key}", value)
  end
end
```

Every response key becomes an instance variable, and the full raw hash is always
retained on `.data`. Unknown properties are kept — they're simply unreachable
without a reader, and `inspect` hides them by filtering to `respond_to?`.

Consequence: the "enforce LTS at the SDK level before properties are removed from
the API response" goal — the motivation behind this work in the JS SDK — **does
not hold in Ruby at all**. It holds fully in PHP and only at the top level in
Python.

**This is a deliberate decision to make, not a bug to fix.** Two options:

- **Keep it.** Ruby stays maximally forward-compatible; users on an old gem can
  reach new API fields via `.data`. Nothing to do.
- **Strip to known properties.** Iterate a generated list of known property names
  instead of the payload. Keep `.data` as the escape hatch, which is a genuine
  advantage over Python and PHP (both discard stripped data entirely). This needs
  the codegen to emit an explicit known-property list per class — do not try to
  derive it from `instance_methods`, since `date_accessor` defines reader-only
  methods and inherited methods pollute the set.

Recommend deciding this **after** P1 and P2 land, and treating it as its own major
release. Do not bundle it in.

---

## Out of scope

- **Date handling improvements.** `date_accessor` re-parses with `Time.parse` on
  _every_ read (no memoization), and a malformed string raises at read time rather
  than at construction — a late, hard-to-trace failure. It also defines a reader
  only, so `device.created_at = x` raises `NoMethodError` while every other
  property is a full `attr_accessor`. All real, all separate.
- **The `GET` vs `POST` inconsistency** in `lib/seam/helpers/action_attempt.rb:40`
  — it polls with `client.get("/action_attempts/get", ...)` while the generated
  route uses `POST`. Unrelated to this work; worth its own issue.

---

## Tests

RSpec via `rake test`. Patterns (see `Rakefile`): `spec/**/*_spec.rb` **and**
`lib/seam/*_spec.rb` — note some specs are colocated with source, which is why
`lib/seam/deep_hash_accessor_spec.rb` exists.

Add coverage for:

- **P1**: `a["locked"] == a.locked` for string and symbol keys; unknown key via
  `#[]` returns `nil` while `.key` raises `NoMethodError`; `a.nested.equal?(a.nested)`
  is `true` after the memoization fix
- **P1c**: a response key containing a dash does not raise and does not abort the
  rest of the resource; `load_from_response(nil)` returns `nil`
- **P1d**: `errors` reflects the new payload after `update_from_response`
- **P2**: `device.properties` is a `DeviceProperties`; `device.properties.locked`
  works; unknown nested key raises `NoMethodError`; `custom_metadata` still
  behaves as free-form; an empty nested object is still a usable object
- update `spec/resources/deep_hash_accessor_spec.rb`, whose empty-hash assertion
  encodes the pre-existing two-shapes behavior

---

## Verification

```
cd /home/user/ruby
bundle install
npm ci
npm run generate     # must be idempotent; review the lib/seam/resources/ diff
rake lint
rake test
```

Then confirm by inspection:

- `lib/seam/resources/device.rb` declares `resource_accessor :properties, DeviceProperties`
  and `DeviceProperties` is defined with its own YARD comments
- `custom_metadata` still falls through to `DeepHashAccessor`
- the four `static-resources.ts`-derived files match the TS string literals

CI regenerates on every non-`main` push and auto-commits `ci: Generate code`
(`.github/workflows/generate.yml`), so the generated diff is the real regression
gate — review it rather than just checking it's green.

---

## Suggested sequencing

1. **P1 + P1b + P1c + P1d** — bug fixes, no codegen changes except the
   `static-resources.ts` string for P1d. Patch release. Land first and separately.
2. **P2** — nested classes. Minor or major depending on whether dropping
   `DeepHashAccessor` for object properties is judged breaking.
3. **P3** — decide, then ship on its own as a major if the answer is yes.
