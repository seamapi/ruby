# frozen_string_literal: true

require "faraday"
require "faraday/retry"

module Seam
  module Http
    module Request
      def self.create_faraday_client(endpoint, auth_headers)
        Faraday.new(endpoint) do |builder|
          builder.request :json
          builder.request :retry, backoff_factor: 2
          builder.response :json
          builder.headers = auth_headers
        end
      end

      def self.handle_error_response(response, method, path)
        status_code = response.status
        request_id = response.headers["seam-request-id"]

        raise Http::UnauthorizedError.new(request_id) if status_code == 401

        error = response.body["error"] || {}
        error_type = error["type"] || "unknown_error"
        error_details = {
          type: error_type,
          message: error["message"] || "Unknown error",
          data: error["data"]
        }

        if error_type == "invalid_input"
          error_details["validation_errors"] = error["validation_errors"]
          raise Http::InvalidInputError.new(error_details, status_code, request_id)
        end

        raise Http::ApiError.new(error_details, status_code, request_id)
      end

      def self.request_seam(client, endpoint, method, path, config = {})
        url = "#{endpoint}#{path}"
        headers = config[:headers] || {}
        response = client.run_request(method, url, config[:body], headers.merge(default_headers))

        if response.success?
          response
        else
          handle_error_response(response, method, path)
        end
      end

      def self.default_headers
        {
          "User-Agent" => "seam-ruby/#{Seam::VERSION}",
          "Content-Type" => "application/json",
          :"seam-sdk-name" => "seamapi/ruby",
          :"seam-sdk-version" => Seam::VERSION,
          :"seam-lts-version" => Seam::LTS_VERSION
        }
      end
    end
  end
end
