# frozen_string_literal: true

module Seam
  module Errors
    # HTTP
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

    class SeamHttpUnauthorizedError < HttpApiError
      def initialize(request_id)
        super({type: "unauthorized", message: "Unauthorized"}, 401, request_id)
      end
    end

    class SeamHttpInvalidInputError < HttpApiError
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

    # Action attempt
    class SeamActionAttemptError < StandardError
      attr_reader :action_attempt

      def initialize(message, action_attempt)
        super(message)
        @action_attempt = action_attempt
      end

      def name
        self.class.name
      end
    end

    class SeamActionAttemptFailedError < SeamActionAttemptError
      attr_reader :code

      def initialize(action_attempt)
        super(action_attempt.error.message, action_attempt)
        @code = action_attempt.error.type
      end
    end

    class SeamActionAttemptTimeoutError < SeamActionAttemptError
      def initialize(action_attempt, timeout)
        message = "Timed out waiting for action attempt after #{timeout}s"
        super(message, action_attempt)
      end
    end
  end
end
