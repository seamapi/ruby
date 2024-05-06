# frozen_string_literal: true

module Seam
  module Clients
    class AcsSystems < BaseClient
      def get(acs_system_id:)
        request_seam_object(
          :post,
          "/acs/systems/get",
          Seam::AcsSystem,
          "acs_system",
          body: {acs_system_id: acs_system_id}.compact
        )
      end

      def list(connected_account_id: nil)
        request_seam_object(
          :post,
          "/acs/systems/list",
          Seam::AcsSystem,
          "acs_systems",
          body: {connected_account_id: connected_account_id}.compact
        )
      end
    end
  end
end
