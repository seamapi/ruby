# frozen_string_literal: true

require "date"

require_relative "errors"
require_relative "null"
require_relative "url_search_params"

module Seam
  class UnserializableParamError < Seam::Error
    attr_reader :param_name

    def initialize(param_name, reason)
      @param_name = param_name
      super("Could not serialize parameter: '#{param_name}' #{reason}")
    end
  end

  def self.replace_null(value)
    case value
    when Seam::Null then nil
    when Hash then value.transform_values { |v| replace_null(v) }
    when Array then value.map { |v| replace_null(v) }
    else value
    end
  end

  # Serializes parameters to a URL query string following the
  # @seamapi/url-search-params-serializer standard:
  # https://github.com/seamapi/url-search-params-serializer
  module UrlSearchParamsSerializer
    # @param params [Hash]
    # @param strict [Boolean] Whether to add +_strict=true+ to a non-empty
    #   query string
    # @return [String] The query string, without a leading +?+
    # @raise [UnserializableParamError]
    def self.serialize_url_search_params(params, strict: false)
      search_params = UrlSearchParams.new
      update_url_search_params(search_params, params, strict: strict)
      search_params.to_s
    end

    # Serializes parameters into an existing {UrlSearchParams} collection,
    # preserving pairs it does not overwrite.
    #
    # @param search_params [UrlSearchParams]
    # @param params [Hash]
    # @param strict [Boolean] Whether to add +_strict=true+ when the
    #   resulting collection is non-empty
    # @return [nil]
    # @raise [UnserializableParamError]
    def self.update_url_search_params(search_params, params, strict: false)
      nested_update(search_params, params, [])
      search_params.sort!

      if strict && !search_params.empty?
        search_params.delete("_strict")
        search_params.append("_strict", "true")
      end

      nil
    end

    def self.nested_update(search_params, params, path)
      params.each do |key, value|
        unless key.is_a?(String) || key.is_a?(Symbol)
          raise UnserializableParamError.new(
            key.inspect,
            "has a name that is not a string which is unsupported"
          )
        end
        key = key.to_s

        if key.include?(".")
          raise UnserializableParamError.new(
            key,
            'contains one or more dots "." in its name which is unsupported'
          )
        end

        current_path = [*path, key]

        if value.is_a?(Hash)
          nested_update(search_params, value, current_path)
          next
        end

        name = current_path.join(".")

        next if value.nil?

        value = value.to_s if value.is_a?(Symbol)

        next if value.is_a?(String) && value.empty?

        if value.is_a?(Array)
          serialize_array(search_params, name, value)
          next
        end

        search_params.set(name, serialize_value(name, value))
      end
    end

    def self.serialize_array(search_params, name, values)
      # The parser reads a single pair with an empty value as an empty array.
      if values.empty?
        search_params.set(name, "")
        return
      end

      values = values.map { |value| value.is_a?(Symbol) ? value.to_s : value }

      if values.length == 1 && values.first == ""
        raise UnserializableParamError.new(
          name,
          "is a single element array containing the empty string which is unsupported"
        )
      end

      if values.any? { |value| value == "" }
        raise UnserializableParamError.new(
          name,
          "is an array containing the empty string which is unsupported"
        )
      end

      if values.any? { |value| value.nil? || value.is_a?(Seam::Null) }
        raise UnserializableParamError.new(
          name,
          "is an array containing null or undefined values which is unsupported"
        )
      end

      values.each { |value| search_params.append(name, serialize_value(name, value)) }
    end

    def self.serialize_value(name, value)
      case value
      when Seam::Null then ""
      when String then value
      when true, false then value.to_s
      when Integer then value.to_s
      when Float then serialize_float(name, value)
      when Time then serialize_time(value)
      when DateTime then serialize_time(value.to_time)
      when Date then serialize_time(Time.utc(value.year, value.month, value.day))
      else
        raise UnserializableParamError.new(name, "is a #{value.class}")
      end
    end

    # Formats a float exactly like ECMAScript Number::toString.
    def self.serialize_float(name, value)
      raise UnserializableParamError.new(name, "is NaN") if value.nan?
      if value.infinite?
        raise UnserializableParamError.new(name, "is #{value.positive? ? "Infinity" : "-Infinity"}")
      end
      return "0" if value.zero?

      digits, point = shortest_decimal(value.abs)
      count = digits.length

      formatted = if point.between?(count, 21)
        digits + "0" * (point - count)
      elsif point.positive? && point <= 21
        "#{digits[0, point]}.#{digits[point..]}"
      elsif point > -6 && point <= 0
        "0.#{"0" * -point}#{digits}"
      else
        mantissa = (count == 1) ? digits : "#{digits[0]}.#{digits[1..]}"
        exponent = point - 1
        "#{mantissa}e#{(exponent >= 0) ? "+" : "-"}#{exponent.abs}"
      end

      value.negative? ? "-#{formatted}" : formatted
    end

    # Returns the shortest round-tripping decimal digits of a positive float
    # and the position of the decimal point relative to the first digit.
    def self.shortest_decimal(value)
      repr = value.to_s

      if repr.include?("e")
        mantissa, exponent = repr.split("e")
        integer_part, fraction_part = mantissa.split(".")
        digits = integer_part + (fraction_part || "")
        point = integer_part.length + exponent.to_i
      else
        integer_part, fraction_part = repr.split(".")
        digits = integer_part + (fraction_part || "")
        point = integer_part.length
      end

      leading_zeros = digits[/\A0*/].length
      digits = digits[leading_zeros..]
      point -= leading_zeros

      [digits.sub(/0+\z/, ""), point]
    end

    # Formats a time exactly like JavaScript's Date#toISOString.
    def self.serialize_time(time)
      utc = time.getutc
      year = if utc.year.between?(0, 9999)
        format("%04d", utc.year)
      elsif utc.year > 9999
        format("+%06d", utc.year)
      else
        format("-%06d", -utc.year)
      end
      format(
        "%s-%02d-%02dT%02d:%02d:%02d.%03dZ",
        year, utc.month, utc.day, utc.hour, utc.min, utc.sec, utc.nsec / 1_000_000
      )
    end
  end
end
