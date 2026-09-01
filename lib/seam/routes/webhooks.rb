# frozen_string_literal: true

require "seam/response"

module Seam
  module Clients
    class Webhooks
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Creates a new [webhook](https://docs.seam.co/developer-tools/webhooks).
      # @param url [String] URL for the new webhook.
      # @param event_types [Array<String>, nil] Types of events that you want the new webhook to receive.
      # @return [Seam::Resources::Webhook] OK
      def create(url:, event_types: nil)
        res = @client.post("/webhooks/create", {url: url, event_types: event_types}.compact)

        Seam::Resources::Webhook.load_from_response(Seam::Http::Response.read(res, "webhook", "/webhooks/create"))
      end

      # Deletes a specified [webhook](https://docs.seam.co/developer-tools/webhooks).
      # @param webhook_id [String] ID of the webhook that you want to delete.
      # @return [nil] OK
      def delete(webhook_id:)
        @client.delete("/webhooks/delete", {webhook_id: webhook_id}.compact)

        nil
      end

      # Gets a specified [webhook](https://docs.seam.co/developer-tools/webhooks).
      # @param webhook_id [String] ID of the webhook that you want to get.
      # @return [Seam::Resources::Webhook] OK
      def get(webhook_id:)
        res = @client.get("/webhooks/get", {webhook_id: webhook_id}.compact)

        Seam::Resources::Webhook.load_from_response(Seam::Http::Response.read(res, "webhook", "/webhooks/get"))
      end

      # Returns a list of all [webhooks](https://docs.seam.co/developer-tools/webhooks).
      # @return [Seam::Resources::Webhook] OK
      def list
        res = @client.get("/webhooks/list")

        Seam::Resources::Webhook.load_from_response(Seam::Http::Response.read_list(res, "webhooks", "/webhooks/list"))
      end

      # Updates a specified [webhook](https://docs.seam.co/developer-tools/webhooks).
      # @param event_types [Array<String>] Types of events that you want the webhook to receive.
      # @param webhook_id [String] ID of the webhook that you want to update.
      # @return [nil] OK
      def update(event_types:, webhook_id:)
        @client.put("/webhooks/update", {event_types: event_types, webhook_id: webhook_id}.compact)

        nil
      end
    end
  end
end
