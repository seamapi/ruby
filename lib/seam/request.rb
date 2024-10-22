# frozen_string_literal: true

require "faraday"
require "faraday/retry"

module Seam
  module Http
    module Request
      def self.create_faraday_client(endpoint, auth_headers, client_options = {}, retry_options = {})
        default_options = {
          url: endpoint,
          headers: auth_headers.merge(default_headers)
        }

        options = deep_merge(default_options, client_options)

        default_retry_options = {
          max: 2,
          backoff_factor: 2
        }

        retry_options = default_retry_options.merge(retry_options)

        Faraday.new(options) do |builder|
          builder.request :json
          builder.request :retry, retry_options
          builder.response :json
        end
      end

      def self.handle_error_response(response, method, path)
        status_code = response.status
        request_id = response.headers["seam-request-id"]

        raise Http::UnauthorizedError.new(request_id) if status_code == 401

        error = response.body.is_a?(Hash) ? response.body["error"] || {} : {}
        error_type = error["type"] || "unknown_error"
        error_message = error["message"] || "Unknown error"
        error_details = {
          type: error_type,
          message: error_message,
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
        response = client.run_request(method, url, config[:body], config[:headers])

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

      def self.deep_merge(hash1, hash2)
        result = hash1.dup
        hash2.each do |key, value|
          result[key] = if value.is_a?(Hash) && result[key].is_a?(Hash)
            deep_merge(result[key], value)
          else
            value
          end
        end
        result
      end

      private_class_method :deep_merge
    end
  end
end
