# frozen_string_literal: true

module Seam
  module Clients
    class PhonesSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create_sandbox_phone(user_identity_id:, assa_abloy_metadata: nil, custom_sdk_installation_id: nil, phone_metadata: nil)
        res = @client.post("/phones/simulate/create_sandbox_phone", {user_identity_id: user_identity_id, assa_abloy_metadata: assa_abloy_metadata, custom_sdk_installation_id: custom_sdk_installation_id, phone_metadata: phone_metadata}.compact)

        Seam::Resources::Phone.load_from_response(res.body["phone"])
      end
    end
  end
end
