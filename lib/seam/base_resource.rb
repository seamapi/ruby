# frozen_string_literal: true

require "time"
require_relative "deep_hash_accessor"

module Seam
  module Resources
    class BaseResource
      attr_accessor :data, :client

      def initialize(data, client = nil)
        @data = data
        @client = client
        process_data_attributes(@data)
      end

      def update_from_response(data)
        @data = data
        process_data_attributes(@data)
      end

      def self.load_from_response(data, client = nil)
        return nil if data.nil?

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

      def [](key)
        name = key.to_s
        return nil unless respond_to?(name)

        public_send(name)
      end

      def self.resource_accessor(attr, resource_class)
        resource_accessors[attr.to_s] = resource_class
        attr_accessor attr
      end

      def self.resource_list_accessor(attr, resource_class)
        resource_list_accessors[attr.to_s] = resource_class
        attr_writer attr

        # A list the response omits, sends as null, or sends as some other type
        # reads as empty rather than nil, so callers can always iterate.
        define_method(attr) do
          value = instance_variable_get(:"@#{attr}")
          value.is_a?(Array) ? value : []
        end
      end

      def self.resource_accessors
        @resource_accessors ||= {}
      end

      def self.resource_list_accessors
        @resource_list_accessors ||= {}
      end

      def self.date_accessor(*attrs)
        attrs.each do |attr|
          define_method(attr) do
            value = instance_variable_get(:"@#{attr}")

            value.nil? ? nil : parse_datetime(value)
          end
        end
      end

      protected

      def parse_datetime(value)
        Time.parse(value)
      end

      def process_data_attributes(data)
        data.each do |key, value|
          next unless key.to_s.match?(/\A[a-zA-Z_][a-zA-Z0-9_]*\z/)

          resource_class = self.class.resource_accessors[key.to_s]
          resource_list_class = self.class.resource_list_accessors[key.to_s]
          value = if resource_class && value.is_a?(Hash)
            resource_class.load_from_response(value, client)
          elsif resource_list_class && value.is_a?(Array)
            resource_list_class.load_from_response(value, client)
          else
            process_hash_value(value)
          end
          instance_variable_set(:"@#{key}", value)
        end
      end

      def process_hash_value(value)
        if value.is_a?(Hash) && !value.empty?
          Seam::DeepHashAccessor.new(value)
        else
          value
        end
      end
    end
  end
end
