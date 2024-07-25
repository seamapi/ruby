# frozen_string_literal: true

require "http"

module Seam
  class Request
    attr_reader :endpoint, :debug

    def initialize(auth_headers:, endpoint:, debug: false)
      @auth_headers = auth_headers
      @endpoint = endpoint
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

    def handle_error_response(response, _method, _uri)
      status_code = response.status.code
      request_id = response.headers["seam-request-id"]

      raise Errors::SeamHttpUnauthorizedError.new(request_id) if status_code == 401

      error = response.parse["error"] || {}
      error_type = error["type"] || "unknown_error"
      error_details = {
        type: error_type,
        message: error["message"] || "Unknown error",
        data: error["data"]
      }

      raise Errors::SeamHttpInvalidInputError.new(error_details, status_code, request_id) if error_type == "invalid_input"

      raise Errors::SeamHttpApiError.new(error_details, status_code, request_id)
    end

    def build_url(uri)
      "#{endpoint}#{uri}"
    end

    def headers
      {
        "User-Agent" => user_agent,
        "Content-Type" => "application/json",
        :"seam-sdk-name" => "seamapi/ruby",
        :"seam-sdk-version" => Seam::VERSION,
        :"seam-lts-version" => Seam::LTS_VERSION
      }.merge(@auth_headers)
    end

    def user_agent
      "seam-ruby/#{Seam::VERSION}"
    end
  end
end
