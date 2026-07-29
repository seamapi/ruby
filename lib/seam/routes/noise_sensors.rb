# frozen_string_literal: true

module Seam
  module Clients
    class NoiseSensors
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def noise_thresholds
        @noise_thresholds ||= Seam::Clients::NoiseSensorsNoiseThresholds.new(client: @client, defaults: @defaults)
      end

      def simulate
        @simulate ||= Seam::Clients::NoiseSensorsSimulate.new(client: @client, defaults: @defaults)
      end

      # Returns a list of all [noise sensors](https://docs.seam.co/capability-guides/noise-sensors).
      # @param connect_webview_id ID of the Connect Webview for which you want to list devices.
      # @param connected_account_id ID of the connected account for which you want to list devices.
      # @param connected_account_ids Array of IDs of the connected accounts for which you want to list devices.
      # @param created_before Timestamp by which to limit returned devices. Returns devices created before this timestamp.
      # @param custom_metadata_has Set of key:value [custom metadata](https://docs.seam.co/core-concepts/devices/adding-custom-metadata-to-a-device) pairs for which you want to list devices.
      # @param customer_key Customer key for which you want to list devices.
      # @param device_ids Array of device IDs for which you want to list devices.
      # @param device_type Device type of the noise sensors that you want to list.
      # @param device_types Device types of the noise sensors that you want to list.
      # @param limit Numerical limit on the number of devices to return.
      # @param manufacturer Manufacturers of the noise sensors that you want to list.
      # @param page_cursor Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search String for which to search. Filters returned devices to include all records that satisfy a partial match using `device_id` (full or partial UUID prefix, minimum 4 characters), `connected_account_id`, `display_name`, `custom_metadata` or `location.location_name`.
      # @param space_id ID of the space for which you want to list devices.
      # @param unstable_location_id
      # @deprecated unstable_location_id: Use `space_id`.
      # @param user_identifier_key Your own internal user ID for the user for which you want to list devices.
      # @return [Seam::Resources::Device] OK
      def list(connect_webview_id: nil, connected_account_id: nil, connected_account_ids: nil, created_before: nil, custom_metadata_has: nil, customer_key: nil, device_ids: nil, device_type: nil, device_types: nil, limit: nil, manufacturer: nil, page_cursor: nil, search: nil, space_id: nil, unstable_location_id: nil, user_identifier_key: nil)
        res = @client.post("/noise_sensors/list", {connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, connected_account_ids: connected_account_ids, created_before: created_before, custom_metadata_has: custom_metadata_has, customer_key: customer_key, device_ids: device_ids, device_type: device_type, device_types: device_types, limit: limit, manufacturer: manufacturer, page_cursor: page_cursor, search: search, space_id: space_id, unstable_location_id: unstable_location_id, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::Device.load_from_response(res.body["devices"])
      end
    end
  end
end
