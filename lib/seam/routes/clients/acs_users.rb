# frozen_string_literal: true

module Seam
  module Clients
    class AcsUsers < BaseClient
      def add_to_access_group(acs_access_group_id:, acs_user_id:)
        request_seam(
          :post,
          "/acs/users/add_to_access_group",
          body: {acs_access_group_id: acs_access_group_id, acs_user_id: acs_user_id}.compact
        )

        nil
      end

      def create(acs_system_id:, access_schedule: nil, acs_access_group_ids: nil, email: nil, email_address: nil, full_name: nil, phone_number: nil, user_identity_id: nil)
        request_seam_object(
          :post,
          "/acs/users/create",
          Seam::AcsUser,
          "acs_user",
          body: {acs_system_id: acs_system_id, access_schedule: access_schedule, acs_access_group_ids: acs_access_group_ids, email: email, email_address: email_address, full_name: full_name, phone_number: phone_number, user_identity_id: user_identity_id}.compact
        )
      end

      def delete(acs_user_id:)
        request_seam(
          :post,
          "/acs/users/delete",
          body: {acs_user_id: acs_user_id}.compact
        )

        nil
      end

      def get(acs_user_id:)
        request_seam_object(
          :post,
          "/acs/users/get",
          Seam::AcsUser,
          "acs_user",
          body: {acs_user_id: acs_user_id}.compact
        )
      end

      def list(acs_system_id: nil, created_before: nil, limit: nil, user_identity_email_address: nil, user_identity_id: nil, user_identity_phone_number: nil)
        request_seam_object(
          :post,
          "/acs/users/list",
          Seam::AcsUser,
          "acs_users",
          body: {acs_system_id: acs_system_id, created_before: created_before, limit: limit, user_identity_email_address: user_identity_email_address, user_identity_id: user_identity_id, user_identity_phone_number: user_identity_phone_number}.compact
        )
      end

      def list_accessible_entrances(acs_user_id:)
        request_seam_object(
          :post,
          "/acs/users/list_accessible_entrances",
          Seam::AcsEntrance,
          "acs_entrances",
          body: {acs_user_id: acs_user_id}.compact
        )
      end

      def remove_from_access_group(acs_access_group_id:, acs_user_id:)
        request_seam(
          :post,
          "/acs/users/remove_from_access_group",
          body: {acs_access_group_id: acs_access_group_id, acs_user_id: acs_user_id}.compact
        )

        nil
      end

      def revoke_access_to_all_entrances(acs_user_id:)
        request_seam(
          :post,
          "/acs/users/revoke_access_to_all_entrances",
          body: {acs_user_id: acs_user_id}.compact
        )

        nil
      end

      def suspend(acs_user_id:)
        request_seam(
          :post,
          "/acs/users/suspend",
          body: {acs_user_id: acs_user_id}.compact
        )

        nil
      end

      def unsuspend(acs_user_id:)
        request_seam(
          :post,
          "/acs/users/unsuspend",
          body: {acs_user_id: acs_user_id}.compact
        )

        nil
      end

      def update(acs_user_id:, access_schedule: nil, email: nil, email_address: nil, full_name: nil, hid_acs_system_id: nil, phone_number: nil)
        request_seam(
          :post,
          "/acs/users/update",
          body: {acs_user_id: acs_user_id, access_schedule: access_schedule, email: email, email_address: email_address, full_name: full_name, hid_acs_system_id: hid_acs_system_id, phone_number: phone_number}.compact
        )

        nil
      end
    end
  end
end
