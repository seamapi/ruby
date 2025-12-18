# frozen_string_literal: true

module Seam
  module Clients
    class AcsAccessGroups
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def add_user(acs_access_group_id:, acs_user_id: nil, user_identity_id: nil)
        @client.post("/acs/access_groups/add_user", {acs_access_group_id: acs_access_group_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      def delete(acs_access_group_id:)
        @client.post("/acs/access_groups/delete", {acs_access_group_id: acs_access_group_id}.compact)

        nil
      end

      def get(acs_access_group_id:)
        res = @client.post("/acs/access_groups/get", {acs_access_group_id: acs_access_group_id}.compact)

        Seam::Resources::AcsAccessGroup.load_from_response(res.body["acs_access_group"])
      end

      def list(acs_system_id: nil, acs_user_id: nil, user_identity_id: nil)
        res = @client.post("/acs/access_groups/list", {acs_system_id: acs_system_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        Seam::Resources::AcsAccessGroup.load_from_response(res.body["acs_access_groups"])
      end

      def list_accessible_entrances(acs_access_group_id:)
        res = @client.post("/acs/access_groups/list_accessible_entrances", {acs_access_group_id: acs_access_group_id}.compact)

        Seam::Resources::AcsEntrance.load_from_response(res.body["acs_entrances"])
      end

      def list_users(acs_access_group_id:)
        res = @client.post("/acs/access_groups/list_users", {acs_access_group_id: acs_access_group_id}.compact)

        Seam::Resources::AcsUser.load_from_response(res.body["acs_users"])
      end

      def remove_user(acs_access_group_id:, acs_user_id: nil, user_identity_id: nil)
        @client.post("/acs/access_groups/remove_user", {acs_access_group_id: acs_access_group_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end
    end
  end
end
