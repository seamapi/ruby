# frozen_string_literal: true

module Seam
  module Clients
    class ConnectWebviews
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create(accepted_capabilities: nil, accepted_providers: nil, automatically_manage_new_devices: nil, custom_metadata: nil, custom_redirect_failure_url: nil, custom_redirect_url: nil, customer_key: nil, device_selection_mode: nil, provider_category: nil, wait_for_device_creation: nil)
        res = @client.post("/connect_webviews/create", {accepted_capabilities: accepted_capabilities, accepted_providers: accepted_providers, automatically_manage_new_devices: automatically_manage_new_devices, custom_metadata: custom_metadata, custom_redirect_failure_url: custom_redirect_failure_url, custom_redirect_url: custom_redirect_url, customer_key: customer_key, device_selection_mode: device_selection_mode, provider_category: provider_category, wait_for_device_creation: wait_for_device_creation}.compact)

        Seam::Resources::ConnectWebview.load_from_response(res.body["connect_webview"])
      end

      def delete(connect_webview_id:)
        @client.post("/connect_webviews/delete", {connect_webview_id: connect_webview_id}.compact)

        nil
      end

      def get(connect_webview_id:)
        res = @client.post("/connect_webviews/get", {connect_webview_id: connect_webview_id}.compact)

        Seam::Resources::ConnectWebview.load_from_response(res.body["connect_webview"])
      end

      def list(custom_metadata_has: nil, customer_key: nil, limit: nil, page_cursor: nil, user_identifier_key: nil)
        res = @client.post("/connect_webviews/list", {custom_metadata_has: custom_metadata_has, customer_key: customer_key, limit: limit, page_cursor: page_cursor, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::ConnectWebview.load_from_response(res.body["connect_webviews"])
      end
    end
  end
end
