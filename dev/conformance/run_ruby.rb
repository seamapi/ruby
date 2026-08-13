# frozen_string_literal: true

# Runs the Ruby serializer over the conformance fixture, printing one line per
# case: the serialized query string, or !ERROR when the case raises
# Seam::UnserializableParamError. Compare byte for byte against the output of
# run_reference.mjs.
#
# Usage: ruby run_ruby.rb FIXTURE_PATH

require "json"

$LOAD_PATH.unshift File.expand_path("../../lib", __dir__)
require "seam/url_search_params_serializer"

def revive(value)
  case value
  when nil
    Seam::NULL
  when Array
    value.map { |element| revive(element) }
  when Hash
    return revive_float(value.fetch("$float")) if value.key?("$float")
    return Integer(value.fetch("$bigint")) if value.key?("$bigint")
    return revive_date(value.fetch("$date")) if value.key?("$date")
    return nil if value.key?("$undefined")

    value.transform_values { |element| revive(element) }
  else
    value
  end
end

def revive_float(repr)
  case repr
  when "NaN" then Float::NAN
  when "Infinity" then Float::INFINITY
  when "-Infinity" then -Float::INFINITY
  else Float(repr)
  end
end

def revive_date(epoch_milliseconds)
  Time.at(
    epoch_milliseconds / 1000,
    (epoch_milliseconds % 1000) * 1000,
    :usec,
    in: "UTC"
  )
end

cases = JSON.parse(File.read(ARGV.fetch(0), encoding: Encoding::UTF_8))

output = cases.map do |params|
  Seam.serialize_url_search_params(revive(params))
rescue Seam::UnserializableParamError
  "!ERROR"
end

puts output
