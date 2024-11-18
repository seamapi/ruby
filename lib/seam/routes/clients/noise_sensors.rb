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

      def list(connect_webview_id: nil, connected_account_id: nil, connected_account_ids: nil, created_before: nil, custom_metadata_has: nil, device_ids: nil, device_type: nil, device_types: nil, exclude_if: nil, include_if: nil, limit: nil, manufacturer: nil, user_identifier_key: nil)
        res = @client.post("/noise_sensors/list", {connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, connected_account_ids: connected_account_ids, created_before: created_before, custom_metadata_has: custom_metadata_has, device_ids: device_ids, device_type: device_type, device_types: device_types, exclude_if: exclude_if, include_if: include_if, limit: limit, manufacturer: manufacturer, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::Device.load_from_response(res.body["devices"])
      end
    end
  end
end
