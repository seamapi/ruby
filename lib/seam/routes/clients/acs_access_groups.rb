# frozen_string_literal: true

module Seam
  module Clients
    class AcsAccessGroups < BaseClient
      def add_user(acs_access_group_id:, acs_user_id:)
        request_seam(
          :post,
          "/acs/access_groups/add_user",
          body: {acs_access_group_id: acs_access_group_id, acs_user_id: acs_user_id}.compact
        )

        nil
      end

      def get(acs_access_group_id:)
        request_seam_object(
          :post,
          "/acs/access_groups/get",
          Seam::AcsAccessGroup,
          "acs_access_group",
          body: {acs_access_group_id: acs_access_group_id}.compact
        )
      end

      def list(acs_system_id: nil, acs_user_id: nil)
        request_seam_object(
          :post,
          "/acs/access_groups/list",
          Seam::AcsAccessGroup,
          "acs_access_groups",
          body: {acs_system_id: acs_system_id, acs_user_id: acs_user_id}.compact
        )
      end

      def list_accessible_entrances(acs_access_group_id:)
        request_seam_object(
          :post,
          "/acs/access_groups/list_accessible_entrances",
          Seam::AcsEntrance,
          "acs_entrances",
          body: {acs_access_group_id: acs_access_group_id}.compact
        )
      end

      def list_users(acs_access_group_id:)
        request_seam_object(
          :post,
          "/acs/access_groups/list_users",
          Seam::AcsUser,
          "acs_users",
          body: {acs_access_group_id: acs_access_group_id}.compact
        )
      end

      def remove_user(acs_access_group_id:, acs_user_id:)
        request_seam(
          :post,
          "/acs/access_groups/remove_user",
          body: {acs_access_group_id: acs_access_group_id, acs_user_id: acs_user_id}.compact
        )

        nil
      end
    end
  end
end
