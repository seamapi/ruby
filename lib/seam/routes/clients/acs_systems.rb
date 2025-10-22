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

      def list(connected_account_id: nil, customer_key: nil)
        res = @client.post("/acs/systems/list", {connected_account_id: connected_account_id, customer_key: customer_key}.compact)

        Seam::Resources::AcsSystem.load_from_response(res.body["acs_systems"])
      end

      def list_compatible_credential_manager_acs_systems(acs_system_id:)
        res = @client.post("/acs/systems/list_compatible_credential_manager_acs_systems", {acs_system_id: acs_system_id}.compact)

        Seam::Resources::AcsSystem.load_from_response(res.body["acs_systems"])
      end

      def report_devices(acs_system_id:, acs_encoders: nil, acs_entrances: nil)
        @client.post("/acs/systems/report_devices", {acs_system_id: acs_system_id, acs_encoders: acs_encoders, acs_entrances: acs_entrances}.compact)

        nil
      end
    end
  end
end
