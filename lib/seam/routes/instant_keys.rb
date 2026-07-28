# frozen_string_literal: true

module Seam
  module Clients
    class InstantKeys
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Deletes a specified [Instant Key](https://docs.seam.co/capability-guides/instant-keys).
      # @param instant_key_id ID of the Instant Key that you want to delete.
      # @return [nil] OK
      def delete(instant_key_id:)
        @client.post("/instant_keys/delete", {instant_key_id: instant_key_id}.compact)

        nil
      end

      # Gets an [instant key](https://docs.seam.co/capability-guides/instant-keys).
      # @param instant_key_id ID of the instant key to get.
      # @param instant_key_url URL of the instant key to get.
      # @return [Seam::Resources::InstantKey] OK
      def get(instant_key_id: nil, instant_key_url: nil)
        res = @client.post("/instant_keys/get", {instant_key_id: instant_key_id, instant_key_url: instant_key_url}.compact)

        Seam::Resources::InstantKey.load_from_response(res.body["instant_key"])
      end

      # Returns a list of all [instant keys](https://docs.seam.co/capability-guides/instant-keys).
      # @param user_identity_id ID of the user identity by which you want to filter the list of Instant Keys.
      # @return [Seam::Resources::InstantKey] OK
      def list(user_identity_id: nil)
        res = @client.post("/instant_keys/list", {user_identity_id: user_identity_id}.compact)

        Seam::Resources::InstantKey.load_from_response(res.body["instant_keys"])
      end
    end
  end
end
