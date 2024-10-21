# frozen_string_literal: true

require_relative "http_single_workspace"

module Seam
  module Http
    def self.new(**args)
      Http::SingleWorkspace.new(**args)
    end

    def self.from_api_key(api_key, endpoint: nil, wait_for_action_attempt: false, debug: false)
      Http::SingleWorkspace.from_api_key(api_key, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt,
        debug: debug)
    end

    def self.from_personal_access_token(personal_access_token, workspace_id, endpoint: nil, wait_for_action_attempt: false, debug: false)
      Http::SingleWorkspace.from_personal_access_token(personal_access_token, workspace_id, endpoint: endpoint,
        wait_for_action_attempt: wait_for_action_attempt, debug: debug)
    end

    class ApiError < StandardError
      attr_reader :code, :status_code, :request_id, :data

      def initialize(error, status_code, request_id)
        super(error[:message])
        @code = error[:type]
        @status_code = status_code
        @request_id = request_id
        @data = error[:data]
      end
    end

    class UnauthorizedError < ApiError
      def initialize(request_id)
        super({type: "unauthorized", message: "Unauthorized"}, 401, request_id)
      end
    end

    class InvalidInputError < ApiError
      attr_reader :validation_errors

      def initialize(error, status_code, request_id)
        super
        @code = "invalid_input"
        @validation_errors = error["validation_errors"] || {}
      end

      def get_validation_error_messages(param_name)
        @validation_errors.dig(param_name, "_errors") || []
      end
    end
  end
end
