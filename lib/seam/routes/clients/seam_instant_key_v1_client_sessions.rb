# frozen_string_literal: true

module Seam
  module Clients
    class SeamInstantKeyV1ClientSessions
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def exchange_short_code(short_code:)
        res = @client.post("/seam/instant_key/v1/client_sessions/exchange_short_code", {short_code: short_code}.compact)

        Seam::Resources::ClientSession.load_from_response(res.body["client_session"])
      end
    end
  end
end
