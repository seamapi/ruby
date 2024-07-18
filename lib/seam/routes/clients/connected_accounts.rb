# frozen_string_literal: true

module Seam
  module Clients
    class ConnectedAccounts < BaseClient
      def delete(connected_account_id:, sync: nil)
        request_seam(
          :post,
          "/connected_accounts/delete",
          body: {connected_account_id: connected_account_id, sync: sync}.compact
        )

        nil
      end

      def get(connected_account_id: nil, email: nil)
        request_seam_object(
          :post,
          "/connected_accounts/get",
          Seam::ConnectedAccount,
          "connected_account",
          body: {connected_account_id: connected_account_id, email: email}.compact
        )
      end

      def list(custom_metadata_has: nil, user_identifier_key: nil)
        request_seam_object(
          :post,
          "/connected_accounts/list",
          Seam::ConnectedAccount,
          "connected_accounts",
          body: {custom_metadata_has: custom_metadata_has, user_identifier_key: user_identifier_key}.compact
        )
      end

      def update(connected_account_id:, automatically_manage_new_devices: nil, custom_metadata: nil)
        request_seam_object(
          :post,
          "/connected_accounts/update",
          Seam::ConnectedAccount,
          "connected_account",
          body: {connected_account_id: connected_account_id, automatically_manage_new_devices: automatically_manage_new_devices, custom_metadata: custom_metadata}.compact
        )
      end
    end
  end
end
