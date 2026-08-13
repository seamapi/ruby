# frozen_string_literal: true

require_relative "request"
require_relative "parse_options"
require_relative "resources/index"
require_relative "routes/index"
require_relative "routes/routes"
require_relative "version"
require_relative "deep_hash_accessor"
require_relative "paginator"

module Seam
  module Http
    class SingleWorkspace
      include Seam::Routes

      attr_reader :client, :defaults

      OPTION_NOT_PROVIDED = Object.new.freeze
      private_constant :OPTION_NOT_PROVIDED

      def initialize(client: nil, api_key: OPTION_NOT_PROVIDED, personal_access_token: OPTION_NOT_PROVIDED,
        workspace_id: OPTION_NOT_PROVIDED, endpoint: OPTION_NOT_PROVIDED,
        wait_for_action_attempt: OPTION_NOT_PROVIDED, timeout: OPTION_NOT_PROVIDED,
        faraday_options: OPTION_NOT_PROVIDED, faraday_retry_options: OPTION_NOT_PROVIDED)
        supplied_options = {
          api_key: api_key,
          personal_access_token: personal_access_token,
          workspace_id: workspace_id,
          endpoint: endpoint,
          wait_for_action_attempt: wait_for_action_attempt,
          timeout: timeout,
          faraday_options: faraday_options,
          faraday_retry_options: faraday_retry_options
        }.reject { |_, value| value.equal?(OPTION_NOT_PROVIDED) }
        invalid_options = supplied_options.keys - [:wait_for_action_attempt]

        if client && invalid_options.any?
          raise Http::Options::SeamInvalidOptionsError.new(
            "The client option cannot be used with any other option, but received: #{supplied_options.keys.join(", ")}"
          )
        end

        wait_for_action_attempt = true if wait_for_action_attempt.equal?(OPTION_NOT_PROVIDED)
        @defaults = Seam::DeepHashAccessor.new({"wait_for_action_attempt" => wait_for_action_attempt})

        # A client carries its own endpoint and authorization, so the auth
        # options are only parsed when one has to be built.
        @client = client || begin
          api_key = nil if api_key.equal?(OPTION_NOT_PROVIDED)
          personal_access_token = nil if personal_access_token.equal?(OPTION_NOT_PROVIDED)
          workspace_id = nil if workspace_id.equal?(OPTION_NOT_PROVIDED)
          endpoint = nil if endpoint.equal?(OPTION_NOT_PROVIDED)
          timeout = nil if timeout.equal?(OPTION_NOT_PROVIDED)
          faraday_options = {} if faraday_options.equal?(OPTION_NOT_PROVIDED)
          faraday_retry_options = {} if faraday_retry_options.equal?(OPTION_NOT_PROVIDED)

          options = Http::Options.parse_options(api_key: api_key, personal_access_token: personal_access_token,
            workspace_id: workspace_id, endpoint: endpoint)
          @endpoint = options[:endpoint]
          @auth_headers = options[:auth_headers]

          Http::Request.create_faraday_client(@endpoint, @auth_headers, faraday_options, faraday_retry_options,
            timeout: timeout)
        end

        initialize_routes(client: @client, defaults: @defaults)
      end

      def create_paginator(request, params = {})
        Paginator.new(request, params)
      end

      def self.from_api_key(api_key, endpoint: nil, wait_for_action_attempt: true, timeout: nil, faraday_options: {}, faraday_retry_options: {})
        new(api_key: api_key, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt,
          timeout: timeout, faraday_options: faraday_options, faraday_retry_options: faraday_retry_options)
      end

      def self.from_personal_access_token(personal_access_token, workspace_id, endpoint: nil, wait_for_action_attempt: true, timeout: nil, faraday_options: {}, faraday_retry_options: {})
        new(personal_access_token: personal_access_token, workspace_id: workspace_id, endpoint: endpoint,
          wait_for_action_attempt: wait_for_action_attempt, timeout: timeout, faraday_options: faraday_options, faraday_retry_options: faraday_retry_options)
      end
    end
  end
end
