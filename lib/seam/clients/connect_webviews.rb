# frozen_string_literal: true

module Seam
  module Clients
    class ConnectWebviews < BaseClient
      def create(accepted_providers: nil, automatically_manage_new_devices: nil, custom_metadata: nil, custom_redirect_failure_url: nil, custom_redirect_url: nil, device_selection_mode: nil, provider_category: nil, wait_for_device_creation: nil)
        request_seam_object(
          :post,
          "/connect_webviews/create",
          Seam::ConnectWebview,
          "connect_webview",
          body: {accepted_providers: accepted_providers, automatically_manage_new_devices: automatically_manage_new_devices, custom_metadata: custom_metadata, custom_redirect_failure_url: custom_redirect_failure_url, custom_redirect_url: custom_redirect_url, device_selection_mode: device_selection_mode, provider_category: provider_category, wait_for_device_creation: wait_for_device_creation}.compact
        )
      end

      def delete(connect_webview_id:)
        request_seam(
          :post,
          "/connect_webviews/delete",
          body: {connect_webview_id: connect_webview_id}.compact
        )

        nil
      end

      def get(connect_webview_id:)
        request_seam_object(
          :post,
          "/connect_webviews/get",
          Seam::ConnectWebview,
          "connect_webview",
          body: {connect_webview_id: connect_webview_id}.compact
        )
      end

      def list(custom_metadata_has: nil, user_identifier_key: nil)
        request_seam_object(
          :post,
          "/connect_webviews/list",
          Seam::ConnectWebview,
          "connect_webviews",
          body: {custom_metadata_has: custom_metadata_has, user_identifier_key: user_identifier_key}.compact
        )
      end
    end
  end
end
