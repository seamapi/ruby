# frozen_string_literal: true

module Seam
  module Clients
    class AcsUsers
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Adds a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) to a specified [access group](https://docs.seam.co/low-level-apis/access-systems/user-management/assigning-users-to-access-groups).
      # @param acs_access_group_id [String] ID of the access group to which you want to add an access system user.
      # @param acs_user_id [String] ID of the access system user that you want to add to an access group.
      # @return [nil] OK
      def add_to_access_group(acs_access_group_id:, acs_user_id:)
        @client.post("/acs/users/add_to_access_group", {acs_access_group_id: acs_access_group_id, acs_user_id: acs_user_id}.compact)

        nil
      end

      # Creates a new [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @param acs_system_id [String] ID of the access system to which you want to add the new access system user.
      # @param full_name [String] Full name of the new access system user.
      # @param access_schedule [Hash, nil] `starts_at` and `ends_at` timestamps for the new access system user's access. If you specify an `access_schedule`, you may include both `starts_at` and `ends_at`. If you omit `starts_at`, it defaults to the current time. `ends_at` is optional and must be a time in the future and after `starts_at`.
      # @param acs_access_group_ids [Array<String>, nil] Array of access group IDs to indicate the access groups to which you want to add the new access system user.
      # @param email [String, nil]
      # @deprecated email: use email_address.
      # @param email_address [String, nil] Email address of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @param phone_number [String, nil] Phone number of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) in E.164 format (for example, `+15555550100`).
      # @param user_identity_id [String, nil] ID of the user identity with which you want to associate the new access system user.
      # @return [Seam::Resources::AcsUser] OK
      def create(acs_system_id:, full_name:, access_schedule: nil, acs_access_group_ids: nil, email: nil, email_address: nil, phone_number: nil, user_identity_id: nil)
        res = @client.post("/acs/users/create", {acs_system_id: acs_system_id, full_name: full_name, access_schedule: access_schedule, acs_access_group_ids: acs_access_group_ids, email: email, email_address: email_address, phone_number: phone_number, user_identity_id: user_identity_id}.compact)

        Seam::Resources::AcsUser.load_from_response(res.body["acs_user"])
      end

      # Deletes a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) and invalidates the access system user's [credentials](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
      # @param acs_system_id [String, nil] ID of the access system that you want to delete. You must provide acs_system_id with user_identity_id.
      # @param acs_user_id [String, nil] ID of the access system user that you want to delete. You must provide either acs_user_id or user_identity_id
      # @param user_identity_id [String, nil] ID of the user identity that you want to delete. You must provide either acs_user_id or user_identity_id. If you provide user_identity_id, you must also provide acs_system_id.
      # @return [nil] OK
      def delete(acs_system_id: nil, acs_user_id: nil, user_identity_id: nil)
        if acs_system_id.nil? && acs_user_id.nil? && user_identity_id.nil?
          raise TypeError, "At least one parameter is required for /acs/users/delete"
        end

        @client.post("/acs/users/delete", {acs_system_id: acs_system_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      # Returns a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @param acs_user_id [String, nil] ID of the access system user that you want to get. You can only provide acs_user_id or user_identity_id.
      # @param acs_system_id [String, nil] ID of the access system that you want to get. You can only provide acs_user_id or user_identity_id.
      # @param user_identity_id [String, nil] ID of the user identity that you want to get. You can only provide acs_user_id or user_identity_id.
      # @return [Seam::Resources::AcsUser] OK
      def get(acs_user_id: nil, acs_system_id: nil, user_identity_id: nil)
        if acs_user_id.nil? && acs_system_id.nil? && user_identity_id.nil?
          raise TypeError, "At least one parameter is required for /acs/users/get"
        end

        res = @client.post("/acs/users/get", {acs_user_id: acs_user_id, acs_system_id: acs_system_id, user_identity_id: user_identity_id}.compact)

        Seam::Resources::AcsUser.load_from_response(res.body["acs_user"])
      end

      # Returns a list of all [access system users](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @param acs_system_id [String, nil] ID of the `acs_system` for which you want to retrieve all access system users.
      # @param created_before [Time, nil] Timestamp by which to limit returned access system users. Returns users created before this timestamp.
      # @param limit [Integer, nil] Maximum number of records to return per page.
      # @param page_cursor [String, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search [String, nil] String for which to search. Filters returned access system users to include all records that satisfy a partial match using `full_name`, `phone_number`, `email_address`, `acs_user_id`, `user_identity_id`, `user_identity_full_name` or `user_identity_phone_number`.
      # @param user_identity_email_address [String, nil] Email address of the user identity for which you want to retrieve all access system users.
      # @param user_identity_id [String, nil] ID of the user identity for which you want to retrieve all access system users.
      # @param user_identity_phone_number [String, nil] Phone number of the user identity for which you want to retrieve all access system users, in [E.164 format](https://www.itu.int/rec/T-REC-E.164/en) (for example, `+15555550100`).
      # @return [Seam::Resources::AcsUser] OK
      def list(acs_system_id: nil, created_before: nil, limit: nil, page_cursor: nil, search: nil, user_identity_email_address: nil, user_identity_id: nil, user_identity_phone_number: nil)
        res = @client.post("/acs/users/list", {acs_system_id: acs_system_id, created_before: created_before, limit: limit, page_cursor: page_cursor, search: search, user_identity_email_address: user_identity_email_address, user_identity_id: user_identity_id, user_identity_phone_number: user_identity_phone_number}.compact)

        Seam::Resources::AcsUser.load_from_response(res.body["acs_users"])
      end

      # Lists the [entrances](https://docs.seam.co/api/acs/entrances) to which a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) has access.
      # @param acs_system_id [String, nil] ID of the access system for which you want to list accessible entrances. You can only provide acs_system_id with user_identity_id.
      # @param acs_user_id [String, nil] ID of the access system user for whom you want to list accessible entrances. You can only provide acs_user_id or user_identity_id.
      # @param user_identity_id [String, nil] ID of the user identity for whom you want to list accessible entrances. You can only provide acs_user_id or user_identity_id.
      # @return [Seam::Resources::AcsEntrance] OK
      def list_accessible_entrances(acs_system_id: nil, acs_user_id: nil, user_identity_id: nil)
        if acs_system_id.nil? && acs_user_id.nil? && user_identity_id.nil?
          raise TypeError, "At least one parameter is required for /acs/users/list_accessible_entrances"
        end

        res = @client.post("/acs/users/list_accessible_entrances", {acs_system_id: acs_system_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        Seam::Resources::AcsEntrance.load_from_response(res.body["acs_entrances"])
      end

      # Removes a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) from a specified [access group](https://docs.seam.co/low-level-apis/access-systems/user-management/assigning-users-to-access-groups).
      # @param acs_access_group_id [String] ID of the access group from which you want to remove an access system user.
      # @param acs_user_id [String, nil] ID of the access system user that you want to remove from an access group. You can only provide acs_user_id or user_identity_id.
      # @param user_identity_id [String, nil] ID of the user identity that you want to remove from an access group. You can only provide acs_user_id or user_identity_id.
      # @return [nil] OK
      def remove_from_access_group(acs_access_group_id:, acs_user_id: nil, user_identity_id: nil)
        @client.post("/acs/users/remove_from_access_group", {acs_access_group_id: acs_access_group_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      # Revokes access to all [entrances](https://docs.seam.co/api/acs/entrances) for a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @param acs_system_id [String, nil] ID of the access system for which you want to revoke access. You can only provide acs_system_id with user_identity_id.
      # @param acs_user_id [String, nil] ID of the access system user for whom you want to revoke access. You can only provide acs_user_id or user_identity_id.
      # @param user_identity_id [String, nil] ID of the user identity for whom you want to revoke access. You can only provide acs_user_id or user_identity_id.
      # @return [nil] OK
      def revoke_access_to_all_entrances(acs_system_id: nil, acs_user_id: nil, user_identity_id: nil)
        if acs_system_id.nil? && acs_user_id.nil? && user_identity_id.nil?
          raise TypeError, "At least one parameter is required for /acs/users/revoke_access_to_all_entrances"
        end

        @client.post("/acs/users/revoke_access_to_all_entrances", {acs_system_id: acs_system_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      # [Suspends](https://docs.seam.co/low-level-apis/access-systems/user-management/suspending-and-unsuspending-users#suspend-an-acs-user) a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management). Suspending an access system user revokes their access temporarily. To restore an access system user's access, you can [unsuspend](https://docs.seam.co/api/acs/users/unsuspend) them.
      # @param acs_system_id [String, nil] ID of the access system that you want to suspend. You can only provide acs_user_id or the combination of acs_system_id and user_identity_id.
      # @param acs_user_id [String, nil] ID of the access system user that you want to suspend. You can only provide acs_user_id or the combination of acs_system_id and user_identity_id.
      # @param user_identity_id [String, nil] ID of the user identity that you want to suspend. You can only provide acs_user_id or the combination of acs_system_id and user_identity_id.
      # @return [nil] OK
      def suspend(acs_system_id: nil, acs_user_id: nil, user_identity_id: nil)
        if acs_system_id.nil? && acs_user_id.nil? && user_identity_id.nil?
          raise TypeError, "At least one parameter is required for /acs/users/suspend"
        end

        @client.post("/acs/users/suspend", {acs_system_id: acs_system_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      # [Unsuspends](https://docs.seam.co/low-level-apis/access-systems/user-management/suspending-and-unsuspending-users#unsuspend-an-acs-user) a specified suspended [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management). While [suspending an access system user](https://docs.seam.co/api/acs/users/suspend) revokes their access temporarily, unsuspending the access system user restores their access.
      # @param acs_system_id [String, nil] ID of the access system of the user that you want to unsuspend. You can only provide acs_system_id with user_identity_id.
      # @param acs_user_id [String, nil] ID of the access system user that you want to unsuspend. You can only provide acs_user_id or the combination of acs_system_id and user_identity_id.
      # @param user_identity_id [String, nil] ID of the user identity that you want to unsuspend. You can only provide acs_user_id or the combination of acs_system_id and user_identity_id.
      # @return [nil] OK
      def unsuspend(acs_system_id: nil, acs_user_id: nil, user_identity_id: nil)
        if acs_system_id.nil? && acs_user_id.nil? && user_identity_id.nil?
          raise TypeError, "At least one parameter is required for /acs/users/unsuspend"
        end

        @client.post("/acs/users/unsuspend", {acs_system_id: acs_system_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      # Updates the properties of a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @param access_schedule [Hash, nil] `starts_at` and `ends_at` timestamps for the access system user's access. If you specify an `access_schedule`, you may include both `starts_at` and `ends_at`. If you omit `starts_at`, it defaults to the current time. `ends_at` is optional and must be a time in the future and after `starts_at`.
      # @param acs_system_id [String, nil] ID of the access system that you want to update. You can only provide acs_system_id with user_identity_id.
      # @param acs_user_id [String, nil] ID of the access system user that you want to update. You can only provide acs_user_id or user_identity_id.
      # @param email [String, nil]
      # @deprecated email: use email_address.
      # @param email_address [String, nil] Email address of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @param full_name [String, nil] Full name of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @param hid_acs_system_id [String, nil] ID of the HID access control system associated with the user.
      # @param phone_number [String, nil] Phone number of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) in E.164 format (for example, `+15555550100`).
      # @param user_identity_id [String, nil] ID of the user identity that you want to update. You can only provide acs_user_id or user_identity_id. If you provide user_identity_id, you must also provide acs_system_id.
      # @return [nil] OK
      def update(access_schedule: nil, acs_system_id: nil, acs_user_id: nil, email: nil, email_address: nil, full_name: nil, hid_acs_system_id: nil, phone_number: nil, user_identity_id: nil)
        if access_schedule.nil? && acs_system_id.nil? && acs_user_id.nil? && email.nil? && email_address.nil? && full_name.nil? && hid_acs_system_id.nil? && phone_number.nil? && user_identity_id.nil?
          raise TypeError, "At least one parameter is required for /acs/users/update"
        end

        @client.post("/acs/users/update", {access_schedule: access_schedule, acs_system_id: acs_system_id, acs_user_id: acs_user_id, email: email, email_address: email_address, full_name: full_name, hid_acs_system_id: hid_acs_system_id, phone_number: phone_number, user_identity_id: user_identity_id}.compact)

        nil
      end
    end
  end
end
