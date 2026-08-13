# frozen_string_literal: true

module Seam
  module Clients
    class AcsSystems
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Returns a specified [access system](https://docs.seam.co/low-level-apis/access-systems).
      # @param acs_system_id [String] ID of the access system that you want to get.
      # @return [Seam::Resources::AcsSystem] OK
      def get(acs_system_id:)
        res = @client.post("/acs/systems/get", {acs_system_id: acs_system_id}.compact)

        Seam::Resources::AcsSystem.load_from_response(res.body["acs_system"])
      end

      # Returns a list of all [access systems](https://docs.seam.co/low-level-apis/access-systems).
      #
      # To filter the list of returned access systems by a specific connected account ID, include the `connected_account_id` in the request body. If you omit the `connected_account_id` parameter, the response includes all access systems connected to your workspace.
      # @param connected_account_id [String, nil] ID of the connected account by which you want to filter the list of access systems.
      # @param customer_key [String, nil] Customer key for which you want to list access systems.
      # @param search [String, nil] String for which to search. Filters returned access systems to include all records that satisfy a partial match using `name` or `acs_system_id`.
      # @return [Seam::Resources::AcsSystem] OK
      def list(connected_account_id: nil, customer_key: nil, search: nil)
        res = @client.post("/acs/systems/list", {connected_account_id: connected_account_id, customer_key: customer_key, search: search}.compact)

        Seam::Resources::AcsSystem.load_from_response(res.body["acs_systems"])
      end

      # Returns a list of all credential manager systems that are compatible with a specified [access system](https://docs.seam.co/low-level-apis/access-systems).
      #
      # Specify the access system for which you want to retrieve all compatible credential manager systems by including the corresponding `acs_system_id` in the request body.
      # @param acs_system_id [String] ID of the access system for which you want to retrieve all compatible credential manager systems.
      # @return [Seam::Resources::AcsSystem] OK
      def list_compatible_credential_manager_acs_systems(acs_system_id:)
        res = @client.post("/acs/systems/list_compatible_credential_manager_acs_systems", {acs_system_id: acs_system_id}.compact)

        Seam::Resources::AcsSystem.load_from_response(res.body["acs_systems"])
      end

      # Reports ACS system device status including encoders and entrances.
      # @param acs_system_id [String] ID of the ACS system to report resources for
      # @param acs_encoders [Array<Hash>, nil] Array of ACS encoders to report
      # @param acs_entrances [Array<Hash>, nil] Array of ACS entrances to report
      # @return [nil] OK
      def report_devices(acs_system_id:, acs_encoders: nil, acs_entrances: nil)
        @client.post("/acs/systems/report_devices", {acs_system_id: acs_system_id, acs_encoders: acs_encoders, acs_entrances: acs_entrances}.compact)

        nil
      end
    end
  end
end
