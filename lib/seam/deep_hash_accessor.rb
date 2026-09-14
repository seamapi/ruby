# frozen_string_literal: true

module Seam
  class DeepHashAccessor
    def initialize(data)
      @data = data
      @values = data.to_h { |key, value| [key.to_s, process_value(value)] }
    end

    def [](key)
      @values[key.to_s]
    end

    def to_h
      @data
    end

    def respond_to_missing?(name, include_private = false)
      @values.key?(name.to_s) || super
    end

    def method_missing(name, *args, &block)
      return @values[name.to_s] if args.empty? && block.nil? && @values.key?(name.to_s)

      super
    end

    private

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
