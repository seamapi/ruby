# frozen_string_literal: true

module Seam
  module Clients
    class UnstablePartnerBuildingBlocks
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def generate_link(bridge_client_machine_identifier_key:, bridge_client_name:, bridge_client_time_zone:)
        @client.post("/unstable_partner/building_blocks/generate_link", {bridge_client_machine_identifier_key: bridge_client_machine_identifier_key, bridge_client_name: bridge_client_name, bridge_client_time_zone: bridge_client_time_zone}.compact)

        nil
      end
    end
  end
end
