# frozen_string_literal: true

module Seam
  module Clients
    class UserIdentities
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def unmanaged
        @unmanaged ||= Seam::Clients::UserIdentitiesUnmanaged.new(client: @client, defaults: @defaults)
      end

      def add_acs_user(acs_user_id:, user_identity_id: nil, user_identity_key: nil)
        @client.post("/user_identities/add_acs_user", {acs_user_id: acs_user_id, user_identity_id: user_identity_id, user_identity_key: user_identity_key}.compact)

        nil
      end

      def create(acs_system_ids: nil, email_address: nil, full_name: nil, phone_number: nil, user_identity_key: nil)
        res = @client.post("/user_identities/create", {acs_system_ids: acs_system_ids, email_address: email_address, full_name: full_name, phone_number: phone_number, user_identity_key: user_identity_key}.compact)

        Seam::Resources::UserIdentity.load_from_response(res.body["user_identity"])
      end

      def delete(user_identity_id:)
        @client.post("/user_identities/delete", {user_identity_id: user_identity_id}.compact)

        nil
      end

      def generate_instant_key(user_identity_id:, customization_profile_id: nil, max_use_count: nil)
        res = @client.post("/user_identities/generate_instant_key", {user_identity_id: user_identity_id, customization_profile_id: customization_profile_id, max_use_count: max_use_count}.compact)

        Seam::Resources::InstantKey.load_from_response(res.body["instant_key"])
      end

      def get(user_identity_id: nil, user_identity_key: nil)
        res = @client.post("/user_identities/get", {user_identity_id: user_identity_id, user_identity_key: user_identity_key}.compact)

        Seam::Resources::UserIdentity.load_from_response(res.body["user_identity"])
      end

      def grant_access_to_device(device_id:, user_identity_id:)
        @client.post("/user_identities/grant_access_to_device", {device_id: device_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      def list(created_before: nil, credential_manager_acs_system_id: nil, limit: nil, page_cursor: nil, search: nil, user_identity_ids: nil)
        res = @client.post("/user_identities/list", {created_before: created_before, credential_manager_acs_system_id: credential_manager_acs_system_id, limit: limit, page_cursor: page_cursor, search: search, user_identity_ids: user_identity_ids}.compact)

        Seam::Resources::UserIdentity.load_from_response(res.body["user_identities"])
      end

      def list_accessible_devices(user_identity_id:)
        res = @client.post("/user_identities/list_accessible_devices", {user_identity_id: user_identity_id}.compact)

        Seam::Resources::Device.load_from_response(res.body["devices"])
      end

      def list_acs_systems(user_identity_id:)
        res = @client.post("/user_identities/list_acs_systems", {user_identity_id: user_identity_id}.compact)

        Seam::Resources::AcsSystem.load_from_response(res.body["acs_systems"])
      end

      def list_acs_users(user_identity_id:)
        res = @client.post("/user_identities/list_acs_users", {user_identity_id: user_identity_id}.compact)

        Seam::Resources::AcsUser.load_from_response(res.body["acs_users"])
      end

      def remove_acs_user(acs_user_id:, user_identity_id:)
        @client.post("/user_identities/remove_acs_user", {acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      def revoke_access_to_device(device_id:, user_identity_id:)
        @client.post("/user_identities/revoke_access_to_device", {device_id: device_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      def update(user_identity_id:, email_address: nil, full_name: nil, phone_number: nil, user_identity_key: nil)
        @client.post("/user_identities/update", {user_identity_id: user_identity_id, email_address: email_address, full_name: full_name, phone_number: phone_number, user_identity_key: user_identity_key}.compact)

        nil
      end
    end
  end
end
