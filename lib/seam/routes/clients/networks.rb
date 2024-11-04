# frozen_string_literal: true

module Seam
  module Clients
    class Networks
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(network_id:)
        res = @client.post("/networks/get", {network_id: network_id}.compact)

        Seam::Resources::Network.load_from_response(res.body["network"])
      end

      def list
        res = @client.post("/networks/list")

        Seam::Resources::Network.load_from_response(res.body["networks"])
      end
    end
  end
end
