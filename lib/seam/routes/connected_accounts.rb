# frozen_string_literal: true

module Seam
  module Clients
    class ConnectedAccounts
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def simulate
        @simulate ||= Seam::Clients::ConnectedAccountsSimulate.new(client: @client, defaults: @defaults)
      end

      # Deletes a specified [connected account](https://docs.seam.co/core-concepts/connected-accounts).
      #
      # Deleting a connected account triggers a `connected_account.deleted` event and removes the connected account and all data associated with the connected account from Seam, including devices, events, access codes, and so on. For every deleted resource, Seam sends a corresponding deleted event, but the resource is not deleted from the provider.
      #
      # For example, if you delete a connected account with a device that has an access code, Seam sends a `connected_account.deleted` event, a `device.deleted` event, and an `access_code.deleted` event, but Seam does not remove the access code from the device.
      # @param connected_account_id [String] ID of the connected account that you want to delete.
      # @return [nil] OK
      def delete(connected_account_id:)
        @client.delete("/connected_accounts/delete", {connected_account_id: connected_account_id}.compact)

        nil
      end

      # Returns a specified [connected account](https://docs.seam.co/core-concepts/connected-accounts).
      # @param connected_account_id [String, nil] ID of the connected account that you want to get.
      # @param email [String, nil] Email address associated with the connected account that you want to get.
      # @return [Seam::Resources::ConnectedAccount] OK
      def get(connected_account_id: nil, email: nil)
        if connected_account_id.nil? && email.nil?
          raise TypeError, "At least one parameter is required for /connected_accounts/get"
        end

        res = @client.get("/connected_accounts/get", {connected_account_id: connected_account_id, email: email}.compact)

        Seam::Resources::ConnectedAccount.load_from_response(res.body["connected_account"])
      end

      # Returns a list of all [connected accounts](https://docs.seam.co/core-concepts/connected-accounts).
      # @param custom_metadata_has [Hash, nil] Custom metadata pairs by which you want to filter connected accounts. Returns connected accounts with `custom_metadata` that contains all of the provided key:value pairs.
      # @param customer_key [String, nil] Customer key by which you want to filter connected accounts.
      # @param limit [Integer, nil] Maximum number of records to return per page.
      # @param page_cursor [String, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search [String, nil] String for which to search. Filters returned connected accounts to include all records that satisfy a partial match using `connected_account_id`, `account_type`, `customer_key`, `custom_metadata`, `user_identifier.username`, `user_identifier.email` or `user_identifier.phone`.
      # @param space_id [String, nil] ID of the space by which you want to filter connected accounts.
      # @param user_identifier_key [String, nil] Your user ID for the user by which you want to filter connected accounts.
      # @return [Seam::Resources::ConnectedAccount] OK
      def list(custom_metadata_has: nil, customer_key: nil, limit: nil, page_cursor: nil, search: nil, space_id: nil, user_identifier_key: nil)
        res = @client.post("/connected_accounts/list", {custom_metadata_has: custom_metadata_has, customer_key: customer_key, limit: limit, page_cursor: page_cursor, search: search, space_id: space_id, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::ConnectedAccount.load_from_response(res.body["connected_accounts"])
      end

      # Request a [connected account](https://docs.seam.co/core-concepts/connected-accounts) sync attempt for the specified `connected_account_id`.
      # @param connected_account_id [String] ID of the connected account that you want to sync.
      # @return [nil] OK
      def sync(connected_account_id:)
        @client.post("/connected_accounts/sync", {connected_account_id: connected_account_id}.compact)

        nil
      end

      # Updates a [connected account](https://docs.seam.co/core-concepts/connected-accounts).
      # @param connected_account_id [String] ID of the connected account that you want to update.
      # @param accepted_capabilities [Array<String>, nil] List of accepted device capabilities that restrict the types of devices that can be connected through this connected account. Valid values are `lock`, `thermostat`, `noise_sensor`, and `access_control`.
      # @param automatically_manage_new_devices [Boolean, nil] Indicates whether newly-added devices should appear as [managed devices](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices).
      # @param custom_metadata [Hash, nil] Custom metadata that you want to associate with the connected account. Entirely replaces the existing custom metadata object. If a new Connect Webview contains custom metadata and is used to reconnect a connected account, the custom metadata from the Connect Webview will entirely replace the entire custom metadata object on the connected account. Supports up to 50 JSON key:value pairs. [Adding custom metadata to a connected account](https://docs.seam.co/core-concepts/connected-accounts/adding-custom-metadata-to-a-connected-account) enables you to store custom information, like customer details or internal IDs from your application. Then, you can [filter connected accounts by the desired metadata](https://docs.seam.co/core-concepts/connected-accounts/filtering-connected-accounts-by-custom-metadata).
      # @param customer_key [String, nil] The customer key to associate with this connected account. If provided, the connected account and all resources under the connected account will be moved to this customer. May only be provided if the connected account is not already associated with a customer.
      # @param display_name [String, nil] Human-readable name for the connected account, shown in the dashboard. For example, `Booking from Airbnb House 1`.
      # @return [nil] OK
      def update(connected_account_id:, accepted_capabilities: nil, automatically_manage_new_devices: nil, custom_metadata: nil, customer_key: nil, display_name: nil)
        @client.patch("/connected_accounts/update", {connected_account_id: connected_account_id, accepted_capabilities: accepted_capabilities, automatically_manage_new_devices: automatically_manage_new_devices, custom_metadata: custom_metadata, customer_key: customer_key, display_name: display_name}.compact)

        nil
      end
    end
  end
end
