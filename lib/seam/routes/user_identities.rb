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

      # Adds a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) to a specified [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity).
      #
      # You must specify either `user_identity_id` or `user_identity_key` to identify the user identity.
      #
      # If `user_identity_key` is provided, but the user identity doesn't exist, a new user identity will be created automatically using information from the ACS user.
      # @param acs_user_id [String] ID of the access system user that you want to add to the user identity.
      # @param user_identity_id [String, nil] ID of the user identity to which you want to add an access system user.
      # @param user_identity_key [String, nil] Key of the user identity to which you want to add an access system user.
      # @return [nil] OK
      def add_acs_user(acs_user_id:, user_identity_id: nil, user_identity_key: nil)
        @client.put("/user_identities/add_acs_user", {acs_user_id: acs_user_id, user_identity_id: user_identity_id, user_identity_key: user_identity_key}.compact)

        nil
      end

      # Creates a new [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity).
      # @param acs_system_ids [Array<String>, nil] List of access system IDs to associate with the new user identity through access system users. If there's no user with the same email address or phone number in the specified access systems, a new access system user is created. If there is an existing user with the same email or phone number in the specified access systems, the user is linked to the user identity.
      # @param email_address [String, Seam::Null, nil] Unique email address for the new user identity.
      # @param full_name [String, Seam::Null, nil] Full name of the user associated with the new user identity.
      # @param phone_number [String, Seam::Null, nil] Unique phone number for the new user identity in E.164 format (for example, +15555550100).
      # @param user_identity_key [String, Seam::Null, nil] Unique key for the new user identity.
      # @return [Seam::Resources::UserIdentity] OK
      def create(acs_system_ids: nil, email_address: nil, full_name: nil, phone_number: nil, user_identity_key: nil)
        res = @client.post("/user_identities/create", {acs_system_ids: acs_system_ids, email_address: email_address, full_name: full_name, phone_number: phone_number, user_identity_key: user_identity_key}.compact)

        Seam::Resources::UserIdentity.load_from_response(res.body["user_identity"])
      end

      # Deletes a specified [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity). This deletes the user identity and all associated resources, including any [credentials](https://docs.seam.co/api/acs/credentials), [acs users](https://docs.seam.co/api/acs/users) and [client sessions](https://docs.seam.co/api/client_sessions).
      # @param user_identity_id [String] ID of the user identity that you want to delete.
      # @return [nil] OK
      def delete(user_identity_id:)
        @client.delete("/user_identities/delete", {user_identity_id: user_identity_id}.compact)

        nil
      end

      # Generates a new [instant key](https://docs.seam.co/capability-guides/instant-keys) for a specified [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity).
      # @param user_identity_id [String] ID of the user identity for which you want to generate an instant key.
      # @param customization_profile_id [String, nil]
      # @param max_use_count [Float, nil] Maximum number of times the instant key can be used. Default: 1.
      # @return [Seam::Resources::InstantKey] OK
      def generate_instant_key(user_identity_id:, customization_profile_id: nil, max_use_count: nil)
        res = @client.post("/user_identities/generate_instant_key", {user_identity_id: user_identity_id, customization_profile_id: customization_profile_id, max_use_count: max_use_count}.compact)

        Seam::Resources::InstantKey.load_from_response(res.body["instant_key"])
      end

      # Returns a specified [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity).
      # @param user_identity_id [String, nil] ID of the user identity that you want to get.
      # @param user_identity_key [String, nil]
      # @return [Seam::Resources::UserIdentity] OK
      def get(user_identity_id: nil, user_identity_key: nil)
        if user_identity_id.nil? && user_identity_key.nil?
          raise TypeError, "At least one parameter is required for /user_identities/get"
        end

        res = @client.get("/user_identities/get", {user_identity_id: user_identity_id, user_identity_key: user_identity_key}.compact)

        Seam::Resources::UserIdentity.load_from_response(res.body["user_identity"])
      end

      # Grants a specified [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) access to a specified [device](https://docs.seam.co/core-concepts/devices/).
      # @param device_id [String] ID of the managed device to which you want to grant access to the user identity.
      # @param user_identity_id [String] ID of the user identity that you want to grant access to a device.
      # @return [nil] OK
      def grant_access_to_device(device_id:, user_identity_id:)
        @client.put("/user_identities/grant_access_to_device", {device_id: device_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      # Returns a list of all [user identities](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity).
      # @param created_before [Time, nil] Timestamp by which to limit returned user identities. Returns user identities created before this timestamp.
      # @param credential_manager_acs_system_id [String, nil] `acs_system_id` of the credential manager by which you want to filter the list of user identities.
      # @param limit [Integer, nil] Maximum number of records to return per page.
      # @param page_cursor [String, Seam::Null, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search [String, nil] String for which to search. Filters returned user identities to include all records that satisfy a partial match using `full_name`, `phone_number`, `email_address` or `user_identity_id`.
      # @param user_identity_ids [Array<String>, nil] Array of user identity IDs by which to filter the list of user identities.
      # @return [Seam::Resources::UserIdentity] OK
      def list(created_before: nil, credential_manager_acs_system_id: nil, limit: nil, page_cursor: nil, search: nil, user_identity_ids: nil)
        res = @client.get("/user_identities/list", {created_before: created_before, credential_manager_acs_system_id: credential_manager_acs_system_id, limit: limit, page_cursor: page_cursor, search: search, user_identity_ids: user_identity_ids}.compact)

        Seam::Resources::UserIdentity.load_from_response(res.body["user_identities"])
      end

      # Returns a list of all [devices](https://docs.seam.co/core-concepts/devices) associated with a specified [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity). This includes devices derived from the access grants assigned to the user identity and devices directly linked to the user identity.
      # @param user_identity_id [String] ID of the user identity for which you want to retrieve all accessible devices.
      # @return [Seam::Resources::Device] OK
      def list_accessible_devices(user_identity_id:)
        res = @client.get("/user_identities/list_accessible_devices", {user_identity_id: user_identity_id}.compact)

        Seam::Resources::Device.load_from_response(res.body["devices"])
      end

      # Returns a list of all [ACS entrances](https://docs.seam.co/api/acs/entrances) accessible to a specified [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity). This includes entrances derived from the access grants assigned to the user identity and entrances accessible through ACS users linked to the user identity.
      # @param user_identity_id [String] ID of the user identity for which you want to retrieve all accessible entrances.
      # @return [Seam::Resources::AcsEntrance] OK
      def list_accessible_entrances(user_identity_id:)
        res = @client.get("/user_identities/list_accessible_entrances", {user_identity_id: user_identity_id}.compact)

        Seam::Resources::AcsEntrance.load_from_response(res.body["acs_entrances"])
      end

      # Returns a list of all [access systems](https://docs.seam.co/low-level-apis/access-systems) associated with a specified [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity).
      # @param user_identity_id [String] ID of the user identity for which you want to retrieve all access systems.
      # @return [Seam::Resources::AcsSystem] OK
      def list_acs_systems(user_identity_id:)
        res = @client.get("/user_identities/list_acs_systems", {user_identity_id: user_identity_id}.compact)

        Seam::Resources::AcsSystem.load_from_response(res.body["acs_systems"])
      end

      # Returns a list of all [access system users](https://docs.seam.co/low-level-apis/access-systems/user-management) assigned to a specified [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity).
      # @param user_identity_id [String] ID of the user identity for which you want to retrieve all access system users.
      # @return [Seam::Resources::AcsUser] OK
      def list_acs_users(user_identity_id:)
        res = @client.get("/user_identities/list_acs_users", {user_identity_id: user_identity_id}.compact)

        Seam::Resources::AcsUser.load_from_response(res.body["acs_users"])
      end

      # Removes a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) from a specified [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity).
      # @param acs_user_id [String] ID of the access system user that you want to remove from the user identity..
      # @param user_identity_id [String] ID of the user identity from which you want to remove an access system user.
      # @return [nil] OK
      def remove_acs_user(acs_user_id:, user_identity_id:)
        @client.delete("/user_identities/remove_acs_user", {acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      # Revokes access to a specified [device](https://docs.seam.co/core-concepts/devices/) from a specified [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity).
      # @param device_id [String] ID of the managed device to which you want to revoke access from the user identity.
      # @param user_identity_id [String] ID of the user identity from which you want to revoke access to a device.
      # @return [nil] OK
      def revoke_access_to_device(device_id:, user_identity_id:)
        @client.delete("/user_identities/revoke_access_to_device", {device_id: device_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      # Updates a specified [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity).
      # @param user_identity_id [String] ID of the user identity that you want to update.
      # @param email_address [String, Seam::Null, nil] Unique email address for the user identity.
      # @param full_name [String, Seam::Null, nil] Full name of the user associated with the user identity.
      # @param phone_number [String, Seam::Null, nil] Unique phone number for the user identity.
      # @param user_identity_key [String, Seam::Null, nil] Unique key for the user identity.
      # @return [nil] OK
      def update(user_identity_id:, email_address: nil, full_name: nil, phone_number: nil, user_identity_key: nil)
        @client.patch("/user_identities/update", {user_identity_id: user_identity_id, email_address: email_address, full_name: full_name, phone_number: phone_number, user_identity_key: user_identity_key}.compact)

        nil
      end
    end
  end
end
