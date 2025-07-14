# frozen_string_literal: true

module Seam
  module Clients
    class ConnectedAccounts
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def delete(connected_account_id:, sync: nil)
        @client.post("/connected_accounts/delete", {connected_account_id: connected_account_id, sync: sync}.compact)

        nil
      end

      def get(connected_account_id: nil, email: nil)
        res = @client.post("/connected_accounts/get", {connected_account_id: connected_account_id, email: email}.compact)

        Seam::Resources::ConnectedAccount.load_from_response(res.body["connected_account"])
      end

      def list(custom_metadata_has: nil, customer_key: nil, limit: nil, page_cursor: nil, search: nil, user_identifier_key: nil)
        res = @client.post("/connected_accounts/list", {custom_metadata_has: custom_metadata_has, customer_key: customer_key, limit: limit, page_cursor: page_cursor, search: search, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::ConnectedAccount.load_from_response(res.body["connected_accounts"])
      end

      def sync(connected_account_id:)
        @client.post("/connected_accounts/sync", {connected_account_id: connected_account_id}.compact)

        nil
      end

      def update(connected_account_id:, accepted_capabilities: nil, automatically_manage_new_devices: nil, custom_metadata: nil)
        @client.post("/connected_accounts/update", {connected_account_id: connected_account_id, accepted_capabilities: accepted_capabilities, automatically_manage_new_devices: automatically_manage_new_devices, custom_metadata: custom_metadata}.compact)

        nil
      end
    end
  end
end
