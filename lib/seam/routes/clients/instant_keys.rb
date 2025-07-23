# frozen_string_literal: true

module Seam
  module Clients
    class InstantKeys
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(instant_key_id:)
        res = @client.post("/instant_keys/get", {instant_key_id: instant_key_id}.compact)

        Seam::Resources::InstantKey.load_from_response(res.body["instant_key"])
      end

      def list(user_identity_id: nil)
        res = @client.post("/instant_keys/list", {user_identity_id: user_identity_id}.compact)

        Seam::Resources::InstantKey.load_from_response(res.body["instant_keys"])
      end
    end
  end
end
