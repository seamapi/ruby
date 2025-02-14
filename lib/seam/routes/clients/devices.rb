# frozen_string_literal: true

module Seam
  module Clients
    class Devices
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def delete(device_id:)
        @client.post("/devices/delete", {device_id: device_id}.compact)

        nil
      end
    end
  end
end
