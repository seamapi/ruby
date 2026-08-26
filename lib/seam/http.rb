# frozen_string_literal: true

require_relative "http_single_workspace"

module Seam
  module Http
    def self.new(**args)
      Http::SingleWorkspace.new(**args)
    end

    def self.from_api_key(api_key, endpoint: nil, wait_for_action_attempt: true, timeout: nil)
      Http::SingleWorkspace.from_api_key(api_key, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt,
        timeout: timeout)
    end

    def self.from_personal_access_token(personal_access_token, workspace_id, endpoint: nil, wait_for_action_attempt: true, timeout: nil)
      Http::SingleWorkspace.from_personal_access_token(personal_access_token, workspace_id, endpoint: endpoint,
        wait_for_action_attempt: wait_for_action_attempt, timeout: timeout)
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

    ValidationError = Data.define(:parameter_name, :error_messages)

    class InvalidInputError < ApiError
      attr_reader :validation_errors

      def initialize(error, status_code, request_id)
        super
        @code = "invalid_input"
        @raw_validation_errors = error["validation_errors"] || {}
        @validation_errors = @raw_validation_errors.filter_map do |parameter_name, _|
          next if parameter_name == "_errors"

          ValidationError.new(parameter_name:, error_messages: get_validation_error_messages(parameter_name))
        end
      end

      def get_validation_error_messages(param_name)
        @raw_validation_errors.dig(param_name, "_errors") || []
      end
    end
  end
end
