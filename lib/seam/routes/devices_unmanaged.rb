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
      # @param device_id [String, nil] ID of the unmanaged device that you want to get.
      # @param name [String, nil] Name of the unmanaged device that you want to get.
      # @return [Seam::Resources::UnmanagedDevice] OK
      def get(device_id: nil, name: nil)
        res = @client.post("/devices/unmanaged/get", {device_id: device_id, name: name}.compact)

        Seam::Resources::UnmanagedDevice.load_from_response(res.body["device"])
      end

      # Returns a list of all [unmanaged devices](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices).
      #
      # An unmanaged device has a limited set of visible properties and a subset of supported events. You cannot control an unmanaged device. Any [access codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) on an unmanaged device are unmanaged. To control an unmanaged device with Seam, [convert it to a managed device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices#convert-an-unmanaged-device-to-managed).
      # @param connect_webview_id [String, nil] ID of the Connect Webview for which you want to list devices.
      # @param connected_account_id [String, nil] ID of the connected account for which you want to list devices.
      # @param connected_account_ids [Array<String>, nil] Array of IDs of the connected accounts for which you want to list devices.
      # @param created_before [Time, nil] Timestamp by which to limit returned devices. Returns devices created before this timestamp.
      # @param customer_key [String, nil] Customer key for which you want to list devices.
      # @param device_ids [Array<String>, nil] Array of device IDs for which you want to list devices.
      # @param device_type [String, nil] Device type for which you want to list devices.
      # @param device_types [Array<String>, nil] Array of device types for which you want to list devices.
      # @param limit [Float, nil] Numerical limit on the number of devices to return.
      # @param manufacturer [String, nil] Manufacturer for which you want to list devices.
      # @param page_cursor [String, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search [String, nil] String for which to search. Filters returned devices to include all records that satisfy a partial match using `device_id` (full or partial UUID prefix, minimum 4 characters), `connected_account_id`, `display_name`, `custom_metadata` or `location.location_name`.
      # @return [Seam::Resources::UnmanagedDevice] OK
      def list(connect_webview_id: nil, connected_account_id: nil, connected_account_ids: nil, created_before: nil, customer_key: nil, device_ids: nil, device_type: nil, device_types: nil, limit: nil, manufacturer: nil, page_cursor: nil, search: nil)
        res = @client.post("/devices/unmanaged/list", {connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, connected_account_ids: connected_account_ids, created_before: created_before, customer_key: customer_key, device_ids: device_ids, device_type: device_type, device_types: device_types, limit: limit, manufacturer: manufacturer, page_cursor: page_cursor, search: search}.compact)

        Seam::Resources::UnmanagedDevice.load_from_response(res.body["devices"])
      end

      # Updates a specified [unmanaged device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices). To convert an unmanaged device to managed, set `is_managed` to `true`.
      #
      # An unmanaged device has a limited set of visible properties and a subset of supported events. You cannot control an unmanaged device. Any [access codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) on an unmanaged device are unmanaged. To control an unmanaged device with Seam, [convert it to a managed device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices#convert-an-unmanaged-device-to-managed).
      # @param device_id [String] ID of the unmanaged device that you want to update.
      # @param custom_metadata [Hash, nil] Custom metadata that you want to associate with the device. Supports up to 50 JSON key:value pairs.
      # @param is_managed [Boolean, nil] Indicates whether the device is managed. Set this parameter to `true` to convert an unmanaged device to managed.
      # @return [nil] OK
      def update(device_id:, custom_metadata: nil, is_managed: nil)
        @client.post("/devices/unmanaged/update", {device_id: device_id, custom_metadata: custom_metadata, is_managed: is_managed}.compact)

        nil
      end
    end
  end
end
