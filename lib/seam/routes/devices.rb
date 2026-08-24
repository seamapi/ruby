# frozen_string_literal: true

module Seam
  module Clients
    class Devices
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def simulate
        @simulate ||= Seam::Clients::DevicesSimulate.new(client: @client, defaults: @defaults)
      end

      def unmanaged
        @unmanaged ||= Seam::Clients::DevicesUnmanaged.new(client: @client, defaults: @defaults)
      end

      # Returns a specified [device](https://docs.seam.co/core-concepts/devices).
      #
      # You must specify either `device_id` or `name`.
      # @param device_id [String, nil] ID of the device that you want to get.
      # @param name [String, nil] Name of the device that you want to get.
      # @return [Seam::Resources::Device] OK
      def get(device_id: nil, name: nil)
        if device_id.nil? && name.nil?
          raise TypeError, "At least one parameter is required for /devices/get"
        end

        res = @client.get("/devices/get", {device_id: device_id, name: name}.compact)

        Seam::Resources::Device.load_from_response(res.body["device"])
      end

      # Returns a list of all [devices](https://docs.seam.co/core-concepts/devices).
      # @param connect_webview_id [String, nil] ID of the Connect Webview for which you want to list devices.
      # @param connected_account_id [String, nil] ID of the connected account for which you want to list devices.
      # @param connected_account_ids [Array<String>, nil] Array of IDs of the connected accounts for which you want to list devices.
      # @param created_before [Time, nil] Timestamp by which to limit returned devices. Returns devices created before this timestamp.
      # @param custom_metadata_has [Hash{String => String, Boolean}, nil] Set of key:value [custom metadata](https://docs.seam.co/core-concepts/devices/adding-custom-metadata-to-a-device) pairs for which you want to list devices. Key names cannot contain a period (.). Specify `null` to match a key that is unset. A key given an empty string is omitted from the filter.
      # @param customer_key [String, nil] Customer key for which you want to list devices.
      # @param device_ids [Array<String>, nil] Array of device IDs for which you want to list devices.
      # @param device_type [String, nil] Device type for which you want to list devices.
      # @param device_types [Array<String>, nil] Array of device types for which you want to list devices.
      # @param limit [Float, nil] Numerical limit on the number of devices to return.
      # @param manufacturer [String, nil] Manufacturer for which you want to list devices.
      # @param page_cursor [String, Seam::Null, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search [String, nil] String for which to search. Filters returned devices to include all records that satisfy a partial match using `device_id` (full or partial UUID prefix, minimum 4 characters), `connected_account_id`, `display_name`, `custom_metadata` or `location.location_name`.
      # @param space_id [String, nil] ID of the space for which you want to list devices.
      # @param unstable_location_id [String, Seam::Null, nil]
      # @deprecated unstable_location_id: Use `space_id`.
      # @param user_identifier_key [String, nil] Your own internal user ID for the user for which you want to list devices.
      # @return [Seam::Resources::Device] OK
      def list(connect_webview_id: nil, connected_account_id: nil, connected_account_ids: nil, created_before: nil, custom_metadata_has: nil, customer_key: nil, device_ids: nil, device_type: nil, device_types: nil, limit: nil, manufacturer: nil, page_cursor: nil, search: nil, space_id: nil, unstable_location_id: nil, user_identifier_key: nil)
        res = @client.get("/devices/list", {connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, connected_account_ids: connected_account_ids, created_before: created_before, custom_metadata_has: custom_metadata_has, customer_key: customer_key, device_ids: device_ids, device_type: device_type, device_types: device_types, limit: limit, manufacturer: manufacturer, page_cursor: page_cursor, search: search, space_id: space_id, unstable_location_id: unstable_location_id, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::Device.load_from_response(res.body["devices"])
      end

      # Returns a list of all device providers.
      #
      # The information that this endpoint returns for each provider includes a set of [capability flags](https://docs.seam.co/capability-guides/device-and-system-capabilities#capability-flags), such as `device_provider.can_remotely_unlock`. If at least one supported device from a provider has a specific capability, the corresponding capability flag is `true`.
      #
      # When you create a [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews), you can customize the providers—that is, the brands—that it displays. In the `/connect_webviews/create` request, include the desired set of device provider keys in the `accepted_providers` parameter. See also [Customize the Brands to Display in Your Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#customize-the-brands-to-display-in-your-connect-webviews).
      # @param provider_category [String, nil] Category for which you want to list providers.
      # @return [Seam::Resources::DeviceProvider] OK
      def list_device_providers(provider_category: nil)
        res = @client.get("/devices/list_device_providers", {provider_category: provider_category}.compact)

        Seam::Resources::DeviceProvider.load_from_response(res.body["device_providers"])
      end

      # Updates provider-specific metadata for devices.
      # @param devices [Array<Hash>] Array of devices with provider metadata to update
      # @return [nil] OK
      def report_provider_metadata(devices:)
        @client.post("/devices/report_provider_metadata", {devices: devices}.compact)

        nil
      end

      # Updates a specified [device](https://docs.seam.co/core-concepts/devices).
      #
      # You can add or change [custom metadata](https://docs.seam.co/core-concepts/devices/adding-custom-metadata-to-a-device) for a device, change the device's name, or [convert a managed device to unmanaged](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices).
      # @param device_id [String] ID of the device that you want to update.
      # @param backup_access_code_pool_enabled [Boolean, nil] Indicates whether the device's [backup access code pool](https://docs.seam.co/low-level-apis/smart-locks/access-codes/backup-access-codes) is enabled. Set to `false` to disable the pool: Seam stops refilling it and removes any backup codes that have not yet been pulled into active use.
      # @param custom_metadata [Hash{String => String, Boolean}, nil] Custom metadata that you want to associate with the device. Supports up to 50 JSON key:value pairs, with key names up to 40 characters long that cannot contain a period (.). [Adding custom metadata to a device](https://docs.seam.co/core-concepts/devices/adding-custom-metadata-to-a-device) enables you to store custom information, like customer details or internal IDs from your application. Then, you can [filter devices by the desired metadata](https://docs.seam.co/core-concepts/devices/filtering-devices-by-custom-metadata). Set a key to `null` or to an empty string to remove that key from the custom metadata.
      # @param is_managed [Boolean, nil] Indicates whether the device is managed. To unmanage a device, set `is_managed` to `false`.
      # @param name [String, Seam::Null, nil] Name for the device.
      # @param properties [Hash, nil]
      # @return [nil] OK
      def update(device_id:, backup_access_code_pool_enabled: nil, custom_metadata: nil, is_managed: nil, name: nil, properties: nil)
        @client.patch("/devices/update", {device_id: device_id, backup_access_code_pool_enabled: backup_access_code_pool_enabled, custom_metadata: custom_metadata, is_managed: is_managed, name: name, properties: properties}.compact)

        nil
      end
    end
  end
end
