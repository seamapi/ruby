# frozen_string_literal: true

# Generates the shared conformance fixture read by both the TypeScript
# reference implementation (run_reference.mjs) and the Ruby port (run_ruby.rb).
#
# Values that JSON cannot express directly use tagged objects so a date does
# not round-trip through the fixture as a string:
#
#   {"$float" => "1.5"}      -> Float / JavaScript number (also "NaN",
#                               "Infinity", and "-Infinity")
#   {"$bigint" => "123"}     -> Integer / JavaScript BigInt
#   {"$date" => 1700000000123} -> Time / JavaScript Date (integer epoch
#                               milliseconds; JavaScript Dates cannot carry
#                               sub-millisecond precision, so truncation is
#                               covered by a Ruby-only unit test instead)
#   {"$undefined" => true}   -> nil / JavaScript undefined
#   JSON null                -> Seam::NULL / JavaScript null
#
# Keys never start with "$" except inside tag objects.
#
# Usage: ruby generate_fixture.rb FIXTURE_PATH [SEED]

require "json"

fixture_path = ARGV.fetch(0)
seed = (ARGV[1] || Random.new_seed).to_i
random = Random.new(seed)

FLOAT = ->(value) { {"$float" => value.to_s} }
BIGINT = ->(value) { {"$bigint" => value.to_s} }
DATE = ->(ms) { {"$date" => ms} }
UNDEFINED = {"$undefined" => true}.freeze

cases = []

# --- Tier 1: hand-built cases covering every branch of the standard. ---

hand_built = [
  # Basic scalars and sorting.
  {"foo" => "d", "bar" => 2},
  {"b" => "2", "a" => "1", "c" => "3"},
  {},
  {"name" => "value"},
  {"a" => true, "b" => false},
  # Absent, null, and empty string in every position.
  {"a" => UNDEFINED},
  {"a" => nil},
  {"a" => ""},
  {"a" => UNDEFINED, "b" => "x"},
  {"a" => nil, "b" => "x"},
  {"a" => "", "b" => "x"},
  {"a" => {"b" => UNDEFINED}},
  {"a" => {"b" => nil}},
  {"a" => {"b" => ""}},
  {"a" => nil, "b" => UNDEFINED, "c" => ""},
  # Nesting, depth >= 3.
  {"a" => {"b" => 1}},
  {"a" => {"b" => {"c" => 1}}},
  {"a" => {"b" => {"c" => {"d" => "deep"}}}},
  {"a" => {"b" => "x", "c" => {"d" => "y"}}, "e" => "z"},
  {"a" => {}},
  {"a" => {"b" => {}}},
  # Arrays.
  {"ids" => []},
  {"ids" => ["a"]},
  {"ids" => ["a", "b"]},
  {"ids" => ["b", "a", "c"]},
  {"ids" => [1, 2, 3]},
  {"ids" => [true, false]},
  {"ids" => [FLOAT.call("1.5"), FLOAT.call("2.5")]},
  {"ids" => [DATE.call(1_700_000_000_123)]},
  {"nested" => {"ids" => ["x", "y"]}},
  # Array error cases.
  {"ids" => [""]},
  {"ids" => ["a", ""]},
  {"ids" => ["", "a"]},
  {"ids" => ["a", nil]},
  {"ids" => [nil]},
  {"ids" => ["a", UNDEFINED]},
  # Key error cases.
  {"a.b" => 1},
  {"a" => {"b.c" => 1}},
  {"." => 1},
  # Explicit null at top level and nested.
  {"a" => nil, "b" => 1},
  {"a" => {"b" => nil, "c" => 2}},
  # Non-finite numbers.
  {"n" => FLOAT.call("NaN")},
  {"n" => FLOAT.call("Infinity")},
  {"n" => FLOAT.call("-Infinity")},
  # Zeros.
  {"n" => FLOAT.call("0.0")},
  {"n" => FLOAT.call("-0.0")},
  {"n" => 0},
  # Integral floats and integers.
  {"n" => FLOAT.call("1.0")},
  {"n" => FLOAT.call("-1.0")},
  {"n" => FLOAT.call("100.0")},
  {"n" => 42},
  {"n" => -42},
  # Exponent boundaries.
  {"n" => FLOAT.call("1e20")},
  {"n" => FLOAT.call("1e21")},
  {"n" => FLOAT.call("1e-6")},
  {"n" => FLOAT.call("1e-7")},
  {"n" => FLOAT.call("-1e20")},
  {"n" => FLOAT.call("-1e21")},
  {"n" => FLOAT.call("-1e-6")},
  {"n" => FLOAT.call("-1e-7")},
  {"n" => FLOAT.call("1.5e22")},
  {"n" => FLOAT.call("123456.789")},
  {"n" => FLOAT.call("0.30000000000000004")},
  {"n" => FLOAT.call("5e-324")},
  {"n" => FLOAT.call("1.7976931348623157e308")},
  # Large integers beyond float precision.
  {"n" => BIGINT.call("9007199254740993")},
  {"n" => BIGINT.call("123456789123456789123456789")},
  {"n" => BIGINT.call("-123456789123456789123456789")},
  # Characters the encoder must handle.
  {"c" => "a *~ b"},
  {"c" => "*"},
  {"c" => "~"},
  {"c" => "a+b"},
  {"c" => "a&b=c"},
  {"c" => "100%"},
  {"c" => "%20"},
  {"c" => "?query#fragment"},
  {"c" => "/slash\\backslash"},
  {"c" => "'quotes\""},
  {"c" => "!()"},
  {"c" => "a\nb\tc"},
  {"a b" => "c d"},
  {"a&b" => "c=d"},
  {"a+b" => "c+d"},
  {"a%b" => "c%d"},
  {"a*~b" => "c*~d"},
  # Multi-byte UTF-8 and astral plane, as both keys and values.
  {"c" => "café"},
  {"c" => "日本語"},
  {"c" => "\u{1F600}"},
  {"\u{1F600}" => "emoji key"},
  {"café" => "ü"},
  # Sort: UTF-16 code unit order puts astral (surrogate) keys before
  # U+E000..U+FFFF, and the sort is stable for repeated names.
  {"\u{FFFF}" => "1", "\u{1F600}" => "2"},
  {"\u{E000}" => "1", "\u{1F600}" => "2", "z" => "3"},
  {"b" => ["2", "1"], "a" => "0", "c" => ["x", "y"]},
  {"Z" => "1", "a" => "2", "A" => "3", "z" => "4", "0" => "5"},
  {"10" => "a", "2" => "b", "1" => "c"},
  # Dates.
  {"t" => DATE.call(0)},
  {"t" => DATE.call(1_700_000_000_000)},
  {"t" => DATE.call(1_700_000_000_123)},
  {"t" => DATE.call(-86_400_000)},
  {"t" => DATE.call(-1)},
  {"t" => DATE.call(253_402_300_799_999)},
  {"t" => DATE.call(946_684_800_000)},
  {"starts_at" => DATE.call(1_700_000_000_001), "ends_at" => DATE.call(1_700_003_600_999)},
  # Unsupported value types (arrays and hashes as array elements).
  {"a" => [["nested"]]},
  {"a" => [{"b" => 1}]},
  # Mixed realistic params.
  {
    "device_ids" => %w[device-1 device-2],
    "limit" => 50,
    "custom_metadata_has" => {"internal_account_id" => "user-1"},
    "starts_at" => DATE.call(1_700_000_000_000),
    "unstable_offset" => FLOAT.call("0.5"),
    "is_managed" => true,
    "search" => nil,
    "page_cursor" => UNDEFINED
  }
]

cases.concat(hand_built)

# --- Tier 2: randomized structural fuzz. ---

KEY_ALPHABETS = [
  ("a".."z").to_a,
  ("A".."Z").to_a + ("0".."9").to_a + ["_", "-"],
  ["k", " ", "+", "&", "=", "%", "*", "~", "é", "日", "\u{1F600}", "\u{FFFF}", "\u{E000}"]
].freeze

def random_key(random)
  alphabet = KEY_ALPHABETS[random.rand(KEY_ALPHABETS.length)]
  length = 1 + random.rand(8)
  key = Array.new(length) { alphabet[random.rand(alphabet.length)] }.join
  # "." is the nesting separator and "$" is the fixture tag prefix.
  key = key.tr(".", "_")
  key.start_with?("$") ? "_#{key}" : key
end

def random_string(random)
  pool = [
    "value", "a *~ b", "", "café", "日本語", "😀", "a&b=c", "+%20", "line\nbreak",
    "x" * (1 + random.rand(20))
  ]
  pool[random.rand(pool.length)]
end

def random_scalar(random)
  case random.rand(10)
  when 0 then random_string(random)
  when 1 then random.rand(2_000_000) - 1_000_000
  when 2 then FLOAT.call((random.rand * 10**(random.rand(41) - 20)).to_s)
  when 3 then [true, false][random.rand(2)]
  when 4 then DATE.call(random.rand(4_102_444_800_000) - 86_400_000)
  when 5 then nil
  when 6 then UNDEFINED
  when 7 then BIGINT.call(random.rand(10**(random.rand(30) + 1)).to_s)
  when 8 then random_string(random)
  else random.rand(100)
  end
end

def random_array(random)
  # Uniform element types keep the case parseable for the round-trip check.
  case random.rand(6)
  when 0 then []
  when 1 then Array.new(1 + random.rand(4)) { random_string(random).sub(/\A\z/, "s") }
  when 2 then Array.new(1 + random.rand(4)) { random.rand(10_000) }
  when 3 then Array.new(1 + random.rand(4)) { FLOAT.call((random.rand * 1000).to_s) }
  when 4 then Array.new(1 + random.rand(4)) { DATE.call(random.rand(4_102_444_800_000)) }
  else Array.new(1 + random.rand(3)) { random_scalar(random) }
  end
end

def random_params(random, depth)
  params = {}
  (1 + random.rand(6)).times do
    key = random_key(random)
    params[key] = case random.rand(10)
    when 0, 1 then (depth < 3) ? random_params(random, depth + 1) : random_scalar(random)
    when 2, 3 then random_array(random)
    else random_scalar(random)
    end
  end
  params
end

3000.times { cases << random_params(random, 0) }

# --- Tier 3: float fuzz. ---

float_cases = []

# Every power of ten across the double range, from both sides of each
# exponent-notation boundary.
(-324..308).each do |exponent|
  float_cases << "1e#{exponent}"
  float_cases << "-1e#{exponent}"
  float_cases << "9.99e#{exponent}"
end

# Random doubles across many magnitudes.
25_000.times do
  exponent = random.rand(640) - 324
  float_cases << (random.rand * 10.0**exponent).to_s
end

# Random bit patterns cover subnormals and extreme mantissas.
5_000.times do
  value = [random.rand(2**64)].pack("Q").unpack1("d")
  float_cases << if value.nan?
    "NaN"
  elsif value.infinite?
    (value > 0) ? "Infinity" : "-Infinity"
  else
    value.to_s
  end
end

float_cases.each { |repr| cases << {"n" => FLOAT.call(repr)} }

File.write(fixture_path, JSON.generate(cases))

warn "Wrote #{cases.length} cases to #{fixture_path} (seed #{seed})"
