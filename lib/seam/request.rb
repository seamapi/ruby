# frozen_string_literal: true

require "http"

module Seam
  class Request
    attr_reader :base_uri, :api_key, :debug

    class Error < StandardError
      attr_reader :status, :response

      def initialize(message, status, response)
        super(message)
        @status = status
        @response = response
      end
    end

    def initialize(api_key:, base_uri:, debug: false)
      @api_key = api_key
      @base_uri = base_uri
      @debug = debug
    end

    def perform(method, uri, config = {})
      Logger.info("Request: #{method} #{uri} #{config}") if debug

      config[:body] = config[:body].to_json if config[:body]

      response = HTTP.request(
        method,
        build_url(uri),
        {headers: headers}.merge(config)
      )

      return response.parse if response.status.success?

      handle_error_response(response, method, uri)
    end

    protected

    def handle_error_response(response, method, uri)
      msg = "Api Error #{response.status.code} #{method} #{uri}"
      code = response.status.code

      if code >= 400 && code < 500 && (err = response.parse["error"])
        msg = "Api Error #{err["type"]}\nrequest_id: #{err["request_id"]}\n#{err["message"]}"
      end

      raise Error.new(msg, code, response)
    end

    def build_url(uri)
      "#{base_uri}#{uri}"
    end

    def headers
      {
        "User-Agent" => user_agent,
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{api_key}",
        :"seam-sdk-name" => "seamapi/ruby",
        :"seam-sdk-version" => Seam::VERSION,
        :"seam-lts-version" => Seam::LTS_VERSION
      }
    end

    def user_agent
      "seam-ruby/#{Seam::VERSION}"
    end
  end
end
