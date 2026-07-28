# frozen_string_literal: true

module Seam
  module Clients
    class DevicesUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Returns a specified [unmanaged device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices).
      #
      # An unmanaged device has a limited set of visible properties and a subset of supported events. You cannot control an unmanaged device. Any [access codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) on an unmanaged device are unmanaged. To control an unmanaged device with Seam, [convert it to a managed device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices#convert-an-unmanaged-device-to-managed).
      #
      # You must specify either `device_id` or `name`.
      # @param device_id ID of the unmanaged device that you want to get.
      # @param name Name of the unmanaged device that you want to get.
      # @return [Seam::Resources::UnmanagedDevice] OK
      def get(device_id: nil, name: nil)
        res = @client.post("/devices/unmanaged/get", {device_id: device_id, name: name}.compact)

        Seam::Resources::UnmanagedDevice.load_from_response(res.body["device"])
      end

      # Returns a list of all [unmanaged devices](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices).
      #
      # An unmanaged device has a limited set of visible properties and a subset of supported events. You cannot control an unmanaged device. Any [access codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) on an unmanaged device are unmanaged. To control an unmanaged device with Seam, [convert it to a managed device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices#convert-an-unmanaged-device-to-managed).
      # @param connect_webview_id ID of the Connect Webview for which you want to list devices.
      # @param connected_account_id ID of the connected account for which you want to list devices.
      # @param connected_account_ids Array of IDs of the connected accounts for which you want to list devices.
      # @param created_before Timestamp by which to limit returned devices. Returns devices created before this timestamp.
      # @param custom_metadata_has Set of key:value [custom metadata](https://docs.seam.co/core-concepts/devices/adding-custom-metadata-to-a-device) pairs for which you want to list devices.
      # @param customer_key Customer key for which you want to list devices.
      # @param device_ids Array of device IDs for which you want to list devices.
      # @param device_type Device type for which you want to list devices.
      # @param device_types Array of device types for which you want to list devices.
      # @param limit Numerical limit on the number of devices to return.
      # @param manufacturer Manufacturer for which you want to list devices.
      # @param page_cursor Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search String for which to search. Filters returned devices to include all records that satisfy a partial match using `device_id` (full or partial UUID prefix, minimum 4 characters), `connected_account_id`, `display_name`, `custom_metadata` or `location.location_name`.
      # @param space_id ID of the space for which you want to list devices.
      # @param unstable_location_id
      # @deprecated unstable_location_id: Use `space_id`.
      # @param user_identifier_key Your own internal user ID for the user for which you want to list devices.
      # @return [Seam::Resources::UnmanagedDevice] OK
      def list(connect_webview_id: nil, connected_account_id: nil, connected_account_ids: nil, created_before: nil, custom_metadata_has: nil, customer_key: nil, device_ids: nil, device_type: nil, device_types: nil, limit: nil, manufacturer: nil, page_cursor: nil, search: nil, space_id: nil, unstable_location_id: nil, user_identifier_key: nil)
        res = @client.post("/devices/unmanaged/list", {connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, connected_account_ids: connected_account_ids, created_before: created_before, custom_metadata_has: custom_metadata_has, customer_key: customer_key, device_ids: device_ids, device_type: device_type, device_types: device_types, limit: limit, manufacturer: manufacturer, page_cursor: page_cursor, search: search, space_id: space_id, unstable_location_id: unstable_location_id, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::UnmanagedDevice.load_from_response(res.body["devices"])
      end

      # Updates a specified [unmanaged device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices). To convert an unmanaged device to managed, set `is_managed` to `true`.
      #
      # An unmanaged device has a limited set of visible properties and a subset of supported events. You cannot control an unmanaged device. Any [access codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) on an unmanaged device are unmanaged. To control an unmanaged device with Seam, [convert it to a managed device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices#convert-an-unmanaged-device-to-managed).
      # @param device_id ID of the unmanaged device that you want to update.
      # @param custom_metadata Custom metadata that you want to associate with the device. Supports up to 50 JSON key:value pairs.
      # @param is_managed Indicates whether the device is managed. Set this parameter to `true` to convert an unmanaged device to managed.
      # @return [nil] OK
      def update(device_id:, custom_metadata: nil, is_managed: nil)
        @client.post("/devices/unmanaged/update", {device_id: device_id, custom_metadata: custom_metadata, is_managed: is_managed}.compact)

        nil
      end
    end
  end
end
