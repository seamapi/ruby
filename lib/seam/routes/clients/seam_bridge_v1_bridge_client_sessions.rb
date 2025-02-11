# frozen_string_literal: true

module Seam
  module Clients
    class SeamBridgeV1BridgeClientSessions
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create(bridge_client_machine_identifier_key:, bridge_client_name:, bridge_client_time_zone:)
        @client.post("/seam/bridge/v1/bridge_client_sessions/create", {bridge_client_machine_identifier_key: bridge_client_machine_identifier_key, bridge_client_name: bridge_client_name, bridge_client_time_zone: bridge_client_time_zone}.compact)

        nil
      end

      def get
        @client.post("/seam/bridge/v1/bridge_client_sessions/get")

        nil
      end
    end
  end
end
