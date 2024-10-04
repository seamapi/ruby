# frozen_string_literal: true

module Seam
  module Clients
    class UserIdentities < BaseClient
      def enrollment_automations
        @enrollment_automations ||= Seam::Clients::UserIdentitiesEnrollmentAutomations.new(self)
      end

      def add_acs_user(acs_user_id:, user_identity_id:)
        request_seam(
          :post,
          "/user_identities/add_acs_user",
          body: {acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact
        )

        nil
      end

      def create(email_address: nil, full_name: nil, phone_number: nil, user_identity_key: nil)
        request_seam_object(
          :post,
          "/user_identities/create",
          Seam::Resources::UserIdentity,
          "user_identity",
          body: {email_address: email_address, full_name: full_name, phone_number: phone_number, user_identity_key: user_identity_key}.compact
        )
      end

      def delete(user_identity_id:)
        request_seam(
          :post,
          "/user_identities/delete",
          body: {user_identity_id: user_identity_id}.compact
        )

        nil
      end

      def get(user_identity_id: nil, user_identity_key: nil)
        request_seam_object(
          :post,
          "/user_identities/get",
          Seam::Resources::UserIdentity,
          "user_identity",
          body: {user_identity_id: user_identity_id, user_identity_key: user_identity_key}.compact
        )
      end

      def grant_access_to_device(device_id:, user_identity_id:)
        request_seam(
          :post,
          "/user_identities/grant_access_to_device",
          body: {device_id: device_id, user_identity_id: user_identity_id}.compact
        )

        nil
      end

      def list(credential_manager_acs_system_id: nil)
        request_seam_object(
          :post,
          "/user_identities/list",
          Seam::Resources::UserIdentity,
          "user_identities",
          body: {credential_manager_acs_system_id: credential_manager_acs_system_id}.compact
        )
      end

      def list_accessible_devices(user_identity_id:)
        request_seam_object(
          :post,
          "/user_identities/list_accessible_devices",
          Seam::Resources::Device,
          "devices",
          body: {user_identity_id: user_identity_id}.compact
        )
      end

      def list_acs_systems(user_identity_id:)
        request_seam_object(
          :post,
          "/user_identities/list_acs_systems",
          Seam::Resources::AcsSystem,
          "acs_systems",
          body: {user_identity_id: user_identity_id}.compact
        )
      end

      def list_acs_users(user_identity_id:)
        request_seam_object(
          :post,
          "/user_identities/list_acs_users",
          Seam::Resources::AcsUser,
          "acs_users",
          body: {user_identity_id: user_identity_id}.compact
        )
      end

      def remove_acs_user(acs_user_id:, user_identity_id:)
        request_seam(
          :post,
          "/user_identities/remove_acs_user",
          body: {acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact
        )

        nil
      end

      def revoke_access_to_device(device_id:, user_identity_id:)
        request_seam(
          :post,
          "/user_identities/revoke_access_to_device",
          body: {device_id: device_id, user_identity_id: user_identity_id}.compact
        )

        nil
      end

      def update(user_identity_id:, email_address: nil, full_name: nil, phone_number: nil, user_identity_key: nil)
        request_seam(
          :post,
          "/user_identities/update",
          body: {user_identity_id: user_identity_id, email_address: email_address, full_name: full_name, phone_number: phone_number, user_identity_key: user_identity_key}.compact
        )

        nil
      end
    end
  end
end
