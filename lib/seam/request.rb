# frozen_string_literal: true

require "faraday"
require "faraday/retry"
require_relative "defaults"
require_relative "version"
require_relative "paginator"
require_relative "strict_url_search_params_serializer"

module Seam
  module Http
    # The Faraday params encoder that applies the Seam URL search params
    # serializer to query params.
    module UrlSearchParamsEncoder
      # Pairs decoded from a query string already present in the request
      # path, passed through {encode} verbatim rather than re-serialized.
      Decoded = Struct.new(:values)

      def self.encode(params)
        search_params = Seam::UrlSearchParams.new
        map_params = {}

        params.each do |name, value|
          if value.is_a?(Decoded)
            value.values.each { |element| search_params.append(name, element) }
          else
            map_params[name] = value
          end
        end

        return search_params.to_s if map_params.empty?

        Seam.update_url_search_params(search_params, map_params)
        search_params.to_s
      end

      # Called by Faraday when a request path carries its own query string.
      def self.decode(query)
        return {} if query.nil? || query.empty?

        pairs = URI.decode_www_form(query.encode(Encoding::UTF_8))
        pairs.each_with_object({}) do |(name, value), decoded|
          (decoded[name] ||= Decoded.new([])).values << value
        end
      end
    end

    module Request
      def self.create_faraday_client(endpoint, auth_headers, faraday_options = {}, faraday_retry_options = {},
        timeout: nil)
        timeout ||= Seam::DEFAULT_TIMEOUT

        default_options = {
          url: endpoint,
          headers: auth_headers.merge(default_headers),
          request: {
            timeout: timeout,
            open_timeout: timeout,
            params_encoder: UrlSearchParamsEncoder
          }
        }

        options = deep_merge(default_options, faraday_options)

        default_faraday_retry_options = {
          max: 2,
          interval: 0.2,
          interval_randomness: 0.2,
          backoff_factor: 2,
          exceptions: Faraday::Retry::Middleware::DEFAULT_EXCEPTIONS + [Faraday::ConnectionFailed],
          retry_statuses: [429] + (500..599).to_a
        }

        faraday_retry_options = default_faraday_retry_options.merge(faraday_retry_options)

        Faraday.new(options) do |builder|
          builder.use ReplaceNullMiddleware
          builder.request :json
          builder.use Seam::PaginationMiddleware
          builder.response :json
          builder.use ResponseMiddleware
          builder.request :retry, faraday_retry_options
        end
      end

      def self.default_headers
        {
          "User-Agent" => "seam-ruby/#{Seam::VERSION}",
          "Content-Type" => "application/json",
          :"seam-sdk-name" => "seamapi/ruby",
          :"seam-sdk-version" => Seam::VERSION
        }
      end

      class ResponseMiddleware < Faraday::Response::RaiseError
        def on_complete(env)
          return if env.success?

          status_code = env.status
          request_id = env.response_headers["seam-request-id"]

          raise Http::UnauthorizedError.new(request_id) if status_code == 401

          if seam_api_error_response?(env)
            body = JSON.parse(env.body)
            error = body["error"]
            error_details = {
              type: error["type"] || "unknown_error",
              message: error["message"] || "Unknown error",
              data: error["data"]
            }

            if error["type"] == "invalid_input"
              error_details["validation_errors"] = error["validation_errors"]
              raise Http::InvalidInputError.new(error_details, status_code, request_id)
            end

            raise Http::ApiError.new(error_details, status_code, request_id)
          end

          super
        end

        def seam_api_error_response?(env)
          return false unless env.response_headers

          content_type = env.response_headers["Content-Type"]
          return false unless content_type&.start_with?("application/json")

          begin
            body = JSON.parse(env.body)
            return false unless body.is_a?(Hash) && body["error"].is_a?(Hash)

            error = body["error"]
            error["type"].is_a?(String) && error["message"].is_a?(String)
          rescue JSON::ParserError
            false
          end
        end
      end

      class ReplaceNullMiddleware < Faraday::Middleware
        def on_request(env)
          return unless env.body.is_a?(Hash) || env.body.is_a?(Array)

          env.body = Seam.replace_null(env.body)
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
