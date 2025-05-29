# frozen_string_literal: true

module Seam
  module Clients
    class AcsUsers
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def add_to_access_group(acs_access_group_id:, acs_user_id:)
        @client.post("/acs/users/add_to_access_group", {acs_access_group_id: acs_access_group_id, acs_user_id: acs_user_id}.compact)

        nil
      end

      def create(acs_system_id:, full_name:, access_schedule: nil, acs_access_group_ids: nil, email: nil, email_address: nil, phone_number: nil, user_identity_id: nil)
        res = @client.post("/acs/users/create", {acs_system_id: acs_system_id, full_name: full_name, access_schedule: access_schedule, acs_access_group_ids: acs_access_group_ids, email: email, email_address: email_address, phone_number: phone_number, user_identity_id: user_identity_id}.compact)

        Seam::Resources::AcsUser.load_from_response(res.body["acs_user"])
      end

      def delete(acs_system_id: nil, acs_user_id: nil, user_identity_id: nil)
        @client.post("/acs/users/delete", {acs_system_id: acs_system_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      def get(acs_system_id: nil, acs_user_id: nil, user_identity_id: nil)
        res = @client.post("/acs/users/get", {acs_system_id: acs_system_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        Seam::Resources::AcsUser.load_from_response(res.body["acs_user"])
      end

      def list(acs_system_id: nil, created_before: nil, limit: nil, page_cursor: nil, search: nil, user_identity_email_address: nil, user_identity_id: nil, user_identity_phone_number: nil)
        res = @client.post("/acs/users/list", {acs_system_id: acs_system_id, created_before: created_before, limit: limit, page_cursor: page_cursor, search: search, user_identity_email_address: user_identity_email_address, user_identity_id: user_identity_id, user_identity_phone_number: user_identity_phone_number}.compact)

        Seam::Resources::AcsUser.load_from_response(res.body["acs_users"])
      end

      def list_accessible_entrances(acs_system_id: nil, acs_user_id: nil, user_identity_id: nil)
        res = @client.post("/acs/users/list_accessible_entrances", {acs_system_id: acs_system_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        Seam::Resources::AcsEntrance.load_from_response(res.body["acs_entrances"])
      end

      def remove_from_access_group(acs_access_group_id:, acs_user_id: nil, user_identity_id: nil)
        @client.post("/acs/users/remove_from_access_group", {acs_access_group_id: acs_access_group_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      def revoke_access_to_all_entrances(acs_system_id: nil, acs_user_id: nil, user_identity_id: nil)
        @client.post("/acs/users/revoke_access_to_all_entrances", {acs_system_id: acs_system_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      def suspend(acs_system_id: nil, acs_user_id: nil, user_identity_id: nil)
        @client.post("/acs/users/suspend", {acs_system_id: acs_system_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      def unsuspend(acs_system_id: nil, acs_user_id: nil, user_identity_id: nil)
        @client.post("/acs/users/unsuspend", {acs_system_id: acs_system_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      def update(access_schedule: nil, acs_system_id: nil, acs_user_id: nil, email: nil, email_address: nil, full_name: nil, hid_acs_system_id: nil, phone_number: nil, user_identity_id: nil)
        @client.post("/acs/users/update", {access_schedule: access_schedule, acs_system_id: acs_system_id, acs_user_id: acs_user_id, email: email, email_address: email_address, full_name: full_name, hid_acs_system_id: hid_acs_system_id, phone_number: phone_number, user_identity_id: user_identity_id}.compact)

        nil
      end
    end
  end
end
