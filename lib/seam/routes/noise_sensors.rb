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
      # @param customer_key Customer key for which you want to list devices.
      # @param device_type Device type of the noise sensors that you want to list.
      # @param device_types Device types of the noise sensors that you want to list.
      # @param manufacturer Manufacturers of the noise sensors that you want to list.
      # @return [Seam::Resources::Device] OK
      def list(connect_webview_id: nil, connected_account_id: nil, customer_key: nil, device_type: nil, device_types: nil, manufacturer: nil)
        res = @client.post("/noise_sensors/list", {connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, customer_key: customer_key, device_type: device_type, device_types: device_types, manufacturer: manufacturer}.compact)

        Seam::Resources::Device.load_from_response(res.body["devices"])
      end
    end
  end
end
