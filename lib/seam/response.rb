# frozen_string_literal: true

module Seam
  module Http
    class InvalidResponseError < StandardError
      attr_reader :path, :response_key

      def initialize(path, response_key, reason)
        super("Seam returned an invalid response for #{path}: expected \"#{response_key}\", #{reason}")
        @path = path
        @response_key = response_key
      end
    end

    module Response
      def self.read(response, response_key, path)
        value = read_response_key(response, response_key, path)
        return value if value.is_a?(Hash)

        raise InvalidResponseError.new(path, response_key, "got #{value.class} instead of an object")
      end

      def self.read_list(response, response_key, path)
        value = read_response_key(response, response_key, path)
        return value if value.is_a?(Array)

        raise InvalidResponseError.new(path, response_key, "got #{value.class} instead of a list")
      end

      def self.read_pagination(body, path)
        unless body.is_a?(Hash) && body.key?("pagination")
          raise InvalidResponseError.new(path, "pagination", "which the response does not contain")
        end

        pagination = body["pagination"]
        return pagination if pagination.is_a?(Hash)

        raise InvalidResponseError.new(path, "pagination", "got #{pagination.class} instead of a pagination object")
      end

      def self.read_response_key(response, response_key, path)
        unless response.success?
          raise InvalidResponseError.new(
            path, response_key, "got a #{response.status} response instead of a success response"
          )
        end

        body = response.body

        unless body.is_a?(Hash)
          raise InvalidResponseError.new(path, response_key, "got #{body.class} instead of a response object")
        end

        unless body.key?(response_key)
          raise InvalidResponseError.new(path, response_key, "which the response does not contain")
        end

        body[response_key]
      end

      private_class_method :read_response_key
    end
  end
end
