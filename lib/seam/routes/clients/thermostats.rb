# frozen_string_literal: true

module Seam
  module Clients
    class Thermostats
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(device_id: nil, name: nil)
        res = @client.post("/thermostats/get", {device_id: device_id, name: name}.compact)

        Seam::Resources::Device.load_from_response(res.body["thermostat"])
      end
    end
  end
end
