# frozen_string_literal: true

require "date"

module Seam
  class DeepHashAccessor
    def initialize(data)
      @data = data
      create_accessor_methods
    end

    def [](key)
      instance_variable_get(:"@#{key}")
    end

    private

    def create_accessor_methods
      @data.each do |key, value|
        define_singleton_method(key) do
          process_value(value)
        end
      end
    end

    def process_value(value)
      case value
      when Hash
        DeepHashAccessor.new(value)
      when Array
        value.map { |v| process_value(v) }
      else
        value
      end
    end
  end
end
