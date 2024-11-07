# frozen_string_literal: true

module Seam
  module Clients
    class AcsSystems
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(acs_system_id:)
        res = @client.post("/acs/systems/get", {acs_system_id: acs_system_id}.compact)

        Seam::Resources::AcsSystem.load_from_response(res.body["acs_system"])
      end

      def list(connected_account_id: nil)
        res = @client.post("/acs/systems/list", {connected_account_id: connected_account_id}.compact)

        Seam::Resources::AcsSystem.load_from_response(res.body["acs_systems"])
      end

      def list_compatible_credential_manager_acs_systems(acs_system_id:)
        res = @client.post("/acs/systems/list_compatible_credential_manager_acs_systems", {acs_system_id: acs_system_id}.compact)

        Seam::Resources::AcsSystem.load_from_response(res.body["acs_systems"])
      end
    end
  end
end
