# frozen_string_literal: true

require "faraday"
require "faraday/retry"

module Seam
  module Http
    module Request
      def self.create_faraday_client(endpoint, auth_headers, faraday_options = {}, faraday_retry_options = {})
        default_options = {
          url: endpoint,
          headers: auth_headers.merge(default_headers)
        }

        options = deep_merge(default_options, faraday_options)

        default_faraday_retry_options = {
          max: 2,
          backoff_factor: 2
        }

        faraday_retry_options = default_faraday_retry_options.merge(faraday_retry_options)

        Faraday.new(options) do |builder|
          builder.request :json
          builder.request :retry, faraday_retry_options
          builder.response :json
          builder.use ResponseMiddleware, retry_options: faraday_retry_options
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

      class ResponseMiddleware < Faraday::Middleware
        def initialize(app, options = {})
          super(app)
          @retry_options = options[:retry_options]
        end

        def on_complete(env)
          return if env.success?

          status_code = env.status
          request_id = env.response_headers["seam-request-id"]

          retry_statuses = @retry_options.fetch(:retry_statuses, [])
          if retry_statuses.include?(status_code)
            raise Faraday::RetriableResponse.new(nil, env.response)
          end

          raise Http::UnauthorizedError.new(request_id) if status_code == 401

          body = begin
            JSON.parse(env.body)
          rescue
            {}
          end
          error = body["error"] || {}
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
