# frozen_string_literal: true

module Seam
  module Errors
    # HTTP
    class SeamHttpApiError < StandardError
      attr_reader :code, :status_code, :request_id, :data

      def initialize(error, status_code, request_id)
        super(error[:message])
        @code = error[:type]
        @status_code = status_code
        @request_id = request_id
        @data = error[:data]
      end
    end

    class SeamHttpUnauthorizedError < SeamHttpApiError
      def initialize(request_id)
        super({type: "unauthorized", message: "Unauthorized"}, 401, request_id)
      end
    end

    class SeamHttpInvalidInputError < SeamHttpApiError
      def initialize(error, status_code, request_id)
        super(error, status_code, request_id)
        @code = "invalid_input"
      end
    end
  end
end
