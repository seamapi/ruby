# frozen_string_literal: true

require "seam/response"

module Seam
  module Clients
    class InstantKeys
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Deletes a specified [Instant Key](https://docs.seam.co/capability-guides/instant-keys).
      # @param instant_key_id [String] ID of the Instant Key that you want to delete.
      # @return [nil] OK
      def delete(instant_key_id:)
        @client.delete("/instant_keys/delete", {instant_key_id: instant_key_id}.compact)

        nil
      end

      # Gets an [instant key](https://docs.seam.co/capability-guides/instant-keys).
      # @param instant_key_id [String, nil] ID of the instant key to get.
      # @param instant_key_url [String, nil] URL of the instant key to get.
      # @return [Seam::Resources::InstantKey] OK
      def get(instant_key_id: nil, instant_key_url: nil)
        if instant_key_id.nil? && instant_key_url.nil?
          raise TypeError, "At least one parameter is required for /instant_keys/get"
        end

        res = @client.get("/instant_keys/get", {instant_key_id: instant_key_id, instant_key_url: instant_key_url}.compact)

        Seam::Resources::InstantKey.load_from_response(Seam::Http::Response.read(res, "instant_key", "/instant_keys/get"))
      end

      # Returns a list of all [instant keys](https://docs.seam.co/capability-guides/instant-keys).
      # @param user_identity_id [String, nil] ID of the user identity by which you want to filter the list of Instant Keys.
      # @return [Seam::Resources::InstantKey] OK
      def list(user_identity_id: nil)
        res = @client.get("/instant_keys/list", {user_identity_id: user_identity_id}.compact)

        Seam::Resources::InstantKey.load_from_response(Seam::Http::Response.read_list(res, "instant_keys", "/instant_keys/list"))
      end
    end
  end
end
