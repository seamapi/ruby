# frozen_string_literal: true

require "seam/response"

module Seam
  module Clients
    class PhonesSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Creates a new simulated phone in a [sandbox workspace](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces). See also [Creating a Simulated Phone for a User Identity](https://docs.seam.co/capability-guides/mobile-access/developing-in-a-sandbox-workspace#creating-a-simulated-phone-for-a-user-identity).
      # @param user_identity_id [String] ID of the user identity that you want to associate with the simulated phone.
      # @param assa_abloy_metadata [Hash, nil] ASSA ABLOY metadata that you want to associate with the simulated phone.
      # @param custom_sdk_installation_id [String, nil] ID of the custom SDK installation that you want to use for the simulated phone.
      # @param phone_metadata [Hash, nil] Metadata that you want to associate with the simulated phone.
      # @return [Seam::Resources::Phone] OK
      def create_sandbox_phone(user_identity_id:, assa_abloy_metadata: nil, custom_sdk_installation_id: nil, phone_metadata: nil)
        res = @client.post("/phones/simulate/create_sandbox_phone", {user_identity_id: user_identity_id, assa_abloy_metadata: assa_abloy_metadata, custom_sdk_installation_id: custom_sdk_installation_id, phone_metadata: phone_metadata}.compact)

        Seam::Resources::Phone.load_from_response(Seam::Http::Response.read(res, "phone", "/phones/simulate/create_sandbox_phone"))
      end
    end
  end
end
