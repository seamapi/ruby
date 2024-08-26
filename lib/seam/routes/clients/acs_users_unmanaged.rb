# frozen_string_literal: true

module Seam
  module Clients
    class AcsUsersUnmanaged < BaseClient
      def get(acs_user_id:)
        request_seam_object(
          :post,
          "/acs/users/unmanaged/get",
          Seam::AcsUser,
          "acs_user",
          body: {acs_user_id: acs_user_id}.compact
        )
      end

      def list(acs_system_id:)
        request_seam_object(
          :post,
          "/acs/users/unmanaged/list",
          Seam::AcsUser,
          "acs_users",
          body: {acs_system_id: acs_system_id}.compact
        )
      end
    end
  end
end
