# frozen_string_literal: true

module Seam
  module Clients
    class DevicesUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(device_id: nil, name: nil)
        res = @client.post("/devices/unmanaged/get", {device_id: device_id, name: name}.compact)

        Seam::Resources::UnmanagedDevice.load_from_response(res.body["device"])
      end

      def list(connect_webview_id: nil, connected_account_id: nil, connected_account_ids: nil, created_before: nil, custom_metadata_has: nil, customer_ids: nil, device_ids: nil, device_type: nil, device_types: nil, exclude_if: nil, include_if: nil, limit: nil, manufacturer: nil, page_cursor: nil, space_id: nil, unstable_location_id: nil, user_identifier_key: nil)
        res = @client.post("/devices/unmanaged/list", {connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, connected_account_ids: connected_account_ids, created_before: created_before, custom_metadata_has: custom_metadata_has, customer_ids: customer_ids, device_ids: device_ids, device_type: device_type, device_types: device_types, exclude_if: exclude_if, include_if: include_if, limit: limit, manufacturer: manufacturer, page_cursor: page_cursor, space_id: space_id, unstable_location_id: unstable_location_id, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::UnmanagedDevice.load_from_response(res.body["devices"])
      end

      def update(device_id:, is_managed:)
        @client.post("/devices/unmanaged/update", {device_id: device_id, is_managed: is_managed}.compact)

        nil
      end
    end
  end
end
