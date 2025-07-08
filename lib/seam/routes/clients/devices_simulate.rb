# frozen_string_literal: true

module Seam
  module Clients
    class DevicesSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def connect(device_id:)
        @client.post("/devices/simulate/connect", {device_id: device_id}.compact)

        nil
      end

      def connect_to_hub(device_id:)
        @client.post("/devices/simulate/connect_to_hub", {device_id: device_id}.compact)

        nil
      end

      def disconnect(device_id:)
        @client.post("/devices/simulate/disconnect", {device_id: device_id}.compact)

        nil
      end

      def disconnect_from_hub(device_id:)
        @client.post("/devices/simulate/disconnect_from_hub", {device_id: device_id}.compact)

        nil
      end

      def remove(device_id:)
        @client.post("/devices/simulate/remove", {device_id: device_id}.compact)

        nil
      end
    end
  end
end
