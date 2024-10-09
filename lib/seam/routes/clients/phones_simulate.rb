# frozen_string_literal: true

module Seam
  module Clients
    class PhonesSimulate < BaseClient
      def create_sandbox_phone(user_identity_id:, assa_abloy_metadata: nil, custom_sdk_installation_id: nil, phone_metadata: nil)
        request_seam_object(
          :post,
          "/phones/simulate/create_sandbox_phone",
          Seam::Resources::Phone,
          "phone",
          body: {user_identity_id: user_identity_id, assa_abloy_metadata: assa_abloy_metadata, custom_sdk_installation_id: custom_sdk_installation_id, phone_metadata: phone_metadata}.compact
        )
      end
    end
  end
end
