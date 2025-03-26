# frozen_string_literal: true

module Seam
  module Clients
    class DevicesSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def access_code_lock(access_code_id:, device_id:)
        @client.post("/devices/simulate/access_code_lock", {access_code_id: access_code_id, device_id: device_id}.compact)

        nil
      end

      def access_code_unlock(access_code_id:, device_id:)
        @client.post("/devices/simulate/access_code_unlock", {access_code_id: access_code_id, device_id: device_id}.compact)

        nil
      end

      def connect(device_id:)
        @client.post("/devices/simulate/connect", {device_id: device_id}.compact)

        nil
      end

      def disconnect(device_id:)
        @client.post("/devices/simulate/disconnect", {device_id: device_id}.compact)

        nil
      end

      def remove(device_id:)
        @client.post("/devices/simulate/remove", {device_id: device_id}.compact)

        nil
      end
    end
  end
end
