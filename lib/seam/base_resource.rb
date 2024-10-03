# frozen_string_literal: true

require_relative "deep_hash_accessor"

module Seam
  module Resources
    class BaseResource
      attr_accessor :data, :client

      def initialize(data, client = nil)
        @data = data
        @client = client

        @data.each do |key, value|
          value = Seam::DeepHashAccessor.new(value) if value.is_a?(Hash)
          instance_variable_set(:"@#{key}", value)
        end
      end

      def update_from_response(data)
        @data = data
        @data.each do |key, value|
          instance_variable_set(:"@#{key}", value)
        end
      end

      def self.load_from_response(data, client = nil)
        if data.is_a?(Array)
          data.map { |d| new(d, client) }
        else
          new(data, client)
        end
      end

      def inspect
        "<#{self.class.name}:#{"0x00%x" % (object_id << 1)}\n" + # rubocop:disable Style/StringConcatenation, Style/FormatString
          instance_variables
            .map { |k| k.to_s.sub("@", "") }
            .filter { |k| k != "data" and k != "client" and respond_to? k }
            .map { |k| "  #{k}=#{send(k).inspect}" }
            .join("\n") + ">"
      end

      def self.date_accessor(*attrs)
        attrs.each do |attr|
          define_method(attr) do
            value = instance_variable_get(:"@#{attr}")

            raise "No value for #{attr} set" if value.nil?

            parse_datetime(value)
          end
        end
      end

      protected

      def parse_datetime(value)
        Time.parse(value)
      end
    end
  end
end
