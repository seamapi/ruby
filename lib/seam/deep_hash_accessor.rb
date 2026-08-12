# frozen_string_literal: true

require "date"

module Seam
  class DeepHashAccessor
    def initialize(data)
      @data = data
      create_accessor_methods
    end

    def [](key)
      # Subscript access is Hash-like and returns nil for unknown keys, while
      # method access continues to raise NoMethodError.
      name = key.to_s
      return nil unless respond_to?(name)

      public_send(name)
    end

    def to_h
      @data
    end

    private

    def create_accessor_methods
      @data.each do |key, value|
        processed = process_value(value)
        define_singleton_method(key) { processed }
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
