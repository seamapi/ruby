# frozen_string_literal: true

require_relative "request"
require_relative "parse_options"
require_relative "version"
require_relative "auth"
require_relative "resources/index"
require_relative "routes/index"
require_relative "routes/routes"

module Seam
  module Http
    class WithoutWorkspace
      attr_reader :client, :defaults

      OPTION_NOT_PROVIDED = Object.new.freeze
      private_constant :OPTION_NOT_PROVIDED

      def initialize(client: nil, personal_access_token: OPTION_NOT_PROVIDED, endpoint: OPTION_NOT_PROVIDED,
        wait_for_action_attempt: OPTION_NOT_PROVIDED, timeout: OPTION_NOT_PROVIDED,
        faraday_options: OPTION_NOT_PROVIDED, faraday_retry_options: OPTION_NOT_PROVIDED)
        supplied_options = {
          personal_access_token: personal_access_token,
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
        @wait_for_action_attempt = wait_for_action_attempt
        @defaults = {"wait_for_action_attempt" => wait_for_action_attempt}

        @client = client || begin
          personal_access_token = nil if personal_access_token.equal?(OPTION_NOT_PROVIDED)
          endpoint = nil if endpoint.equal?(OPTION_NOT_PROVIDED)
          timeout = nil if timeout.equal?(OPTION_NOT_PROVIDED)
          faraday_options = {} if faraday_options.equal?(OPTION_NOT_PROVIDED)
          faraday_retry_options = {} if faraday_retry_options.equal?(OPTION_NOT_PROVIDED)

          options = Http::Options.parse_without_workspace_options(personal_access_token: personal_access_token,
            endpoint: endpoint)
          @endpoint = options[:endpoint]
          @auth_headers = options[:auth_headers]

          Http::Request.create_faraday_client(@endpoint, @auth_headers, faraday_options,
            faraday_retry_options, timeout: timeout)
        end
      end

      def workspaces
        @workspaces ||= WorkspacesProxy.new(Seam::Clients::Workspaces.new(client: @client, defaults: @defaults))
      end

      def self.from_personal_access_token(personal_access_token, endpoint: nil, wait_for_action_attempt: true,
        timeout: nil, faraday_options: {}, faraday_retry_options: {})
        new(
          personal_access_token: personal_access_token,
          endpoint: endpoint,
          wait_for_action_attempt: wait_for_action_attempt,
          timeout: timeout,
          faraday_options: faraday_options,
          faraday_retry_options: faraday_retry_options
        )
      end
    end

    class WorkspacesProxy
      def initialize(workspaces)
        @workspaces = workspaces
      end

      def list(**kwargs)
        @workspaces.list(**kwargs)
      end

      def create(**kwargs)
        @workspaces.create(**kwargs)
      end
    end

    private_constant :WorkspacesProxy
  end
end
