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

      def list(owner_user_identity_id: nil)
        request_seam_object(
          :post,
          "/phones/list",
          Seam::Phone,
          "phones",
          body: {owner_user_identity_id: owner_user_identity_id}.compact
        )
      end
    end
  end
end
