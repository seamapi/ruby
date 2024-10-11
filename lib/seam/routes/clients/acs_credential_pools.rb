# frozen_string_literal: true

module Seam
  module Clients
    class AcsCredentialPools < BaseClient
      def list(acs_system_id:)
        request_seam_object(
          :post,
          "/acs/credential_pools/list",
          Seam::Resources::AcsCredentialPool,
          "acs_credential_pools",
          body: {acs_system_id: acs_system_id}.compact
        )
      end
    end
  end
end
