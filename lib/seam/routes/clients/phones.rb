# frozen_string_literal: true

module Seam
  module Clients
    class Phones < BaseClient
      def simulate
        @simulate ||= Seam::Clients::PhonesSimulate.new(self)
      end

      def deactivate(device_id:)
        request_seam(
          :post,
          "/phones/deactivate",
          body: {device_id: device_id}.compact
        )

        nil
      end

      def list(acs_credential_id: nil, owner_user_identity_id: nil)
        request_seam_object(
          :post,
          "/phones/list",
          Seam::Resources::Phone,
          "phones",
          body: {acs_credential_id: acs_credential_id, owner_user_identity_id: owner_user_identity_id}.compact
        )
      end
    end
  end
end
