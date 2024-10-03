# frozen_string_literal: true

require_relative "http_single_workspace"

module Seam
  module Http
    def self.new(**args)
      Http::SingleWorkspace.new(**args)
    end

    class HttpApiError < StandardError
      attr_reader :code, :status_code, :request_id, :data

      def initialize(error, status_code, request_id)
        super(error[:message])
        @code = error[:type]
        @status_code = status_code
        @request_id = request_id
        @data = error[:data]
      end
    end

    class HttpUnauthorizedError < HttpApiError
      def initialize(request_id)
        super({type: "unauthorized", message: "Unauthorized"}, 401, request_id)
      end
    end

    class InvalidInputError < HttpApiError
      attr_reader :validation_errors

      def initialize(error, status_code, request_id)
        super(error, status_code, request_id)
        @code = "invalid_input"
        @validation_errors = error["validation_errors"] || {}
      end

      def get_validation_error_messages(param_name)
        @validation_errors.dig(param_name, "_errors") || []
      end
    end
  end
end
