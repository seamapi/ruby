# frozen_string_literal: true

module Seam
  module Clients
    class AcsAccessGroups
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Adds a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) to a specified [access group](https://docs.seam.co/low-level-apis/access-systems/user-management/assigning-users-to-access-groups).
      # @param acs_access_group_id ID of the access group to which you want to add an access system user.
      # @param acs_user_id ID of the access system user that you want to add to an access group. You can only provide one of acs_user_id or user_identity_id.
      # @param user_identity_id ID of the desired user identity that you want to add to an access group. You can only provide one of acs_user_id or user_identity_id. If the ACS system contains an ACS user with the same `email_address` or `phone_number` as the user identity that you specify, they are linked, and the access group membership belongs to the ACS user. If the ACS system does not have a corresponding ACS user, one is created.
      # @return [nil] OK
      def add_user(acs_access_group_id:, acs_user_id: nil, user_identity_id: nil)
        @client.post("/acs/access_groups/add_user", {acs_access_group_id: acs_access_group_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      # Deletes a specified [access group](https://docs.seam.co/low-level-apis/access-systems/user-management/assigning-users-to-access-groups).
      # @param acs_access_group_id ID of the access group that you want to delete.
      # @return [nil] OK
      def delete(acs_access_group_id:)
        @client.post("/acs/access_groups/delete", {acs_access_group_id: acs_access_group_id}.compact)

        nil
      end

      # Returns a specified [access group](https://docs.seam.co/low-level-apis/access-systems/user-management/assigning-users-to-access-groups).
      # @param acs_access_group_id ID of the access group that you want to get.
      # @return [Seam::Resources::AcsAccessGroup] OK
      def get(acs_access_group_id:)
        res = @client.post("/acs/access_groups/get", {acs_access_group_id: acs_access_group_id}.compact)

        Seam::Resources::AcsAccessGroup.load_from_response(res.body["acs_access_group"])
      end

      # Returns a list of all [access groups](https://docs.seam.co/low-level-apis/access-systems/user-management/assigning-users-to-access-groups).
      # @param acs_system_id ID of the access system for which you want to retrieve all access groups.
      # @param acs_user_id ID of the access system user for which you want to retrieve all access groups.
      # @param search String for which to search. Filters returned access groups to include all records that satisfy a partial match using `name` or `acs_access_group_id`.
      # @param user_identity_id ID of the user identity for which you want to retrieve all access groups.
      # @return [Seam::Resources::AcsAccessGroup] OK
      def list(acs_system_id: nil, acs_user_id: nil, search: nil, user_identity_id: nil)
        res = @client.post("/acs/access_groups/list", {acs_system_id: acs_system_id, acs_user_id: acs_user_id, search: search, user_identity_id: user_identity_id}.compact)

        Seam::Resources::AcsAccessGroup.load_from_response(res.body["acs_access_groups"])
      end

      # Returns a list of all accessible entrances for a specified [access group](https://docs.seam.co/low-level-apis/access-systems/user-management/assigning-users-to-access-groups).
      # @param acs_access_group_id ID of the access group for which you want to retrieve all accessible entrances.
      # @return [Seam::Resources::AcsEntrance] OK
      def list_accessible_entrances(acs_access_group_id:)
        res = @client.post("/acs/access_groups/list_accessible_entrances", {acs_access_group_id: acs_access_group_id}.compact)

        Seam::Resources::AcsEntrance.load_from_response(res.body["acs_entrances"])
      end

      # Returns a list of all [access system users](https://docs.seam.co/low-level-apis/access-systems/user-management) in an [access group](https://docs.seam.co/low-level-apis/access-systems/user-management/assigning-users-to-access-groups).
      # @param acs_access_group_id ID of the access group for which you want to retrieve all access system users.
      # @return [Seam::Resources::AcsUser] OK
      def list_users(acs_access_group_id:)
        res = @client.post("/acs/access_groups/list_users", {acs_access_group_id: acs_access_group_id}.compact)

        Seam::Resources::AcsUser.load_from_response(res.body["acs_users"])
      end

      # Removes a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) from a specified [access group](https://docs.seam.co/low-level-apis/access-systems/user-management/assigning-users-to-access-groups).
      # @param acs_access_group_id ID of the access group from which you want to remove an access system user.
      # @param acs_user_id ID of the access system user that you want to remove from an access group.
      # @param user_identity_id ID of the user identity associated with the user that you want to remove from an access group.
      # @return [nil] OK
      def remove_user(acs_access_group_id:, acs_user_id: nil, user_identity_id: nil)
        @client.post("/acs/access_groups/remove_user", {acs_access_group_id: acs_access_group_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end
    end
  end
end
