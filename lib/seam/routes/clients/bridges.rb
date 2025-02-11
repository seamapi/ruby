# frozen_string_literal: true

module Seam
  module Clients
    class Bridges
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(bridge_id:)
        @client.post("/bridges/get", {bridge_id: bridge_id}.compact)

        nil
      end
    end
  end
end
