# frozen_string_literal: true

module Seam
  module Clients
    class AcsAccessGroupsUnmanaged < BaseClient
      def get(acs_access_group_id:)
        request_seam(
          :post,
          "/acs/access_groups/unmanaged/get",
          body: {acs_access_group_id: acs_access_group_id}.compact
        )

        nil
      end

      def list(acs_system_id: nil, acs_user_id: nil)
        request_seam(
          :post,
          "/acs/access_groups/unmanaged/list",
          body: {acs_system_id: acs_system_id, acs_user_id: acs_user_id}.compact
        )

        nil
      end
    end
  end
end
