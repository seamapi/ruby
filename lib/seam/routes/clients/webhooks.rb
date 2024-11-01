# frozen_string_literal: true

module Seam
  module Clients
    class Webhooks
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create(url:, event_types: nil)
        res = @client.post("/webhooks/create", {url: url, event_types: event_types}.compact)

        Seam::Resources::Webhook.load_from_response(res.body["webhook"])
      end

      def delete(webhook_id:)
        @client.post("/webhooks/delete", {webhook_id: webhook_id}.compact)

        nil
      end

      def get(webhook_id:)
        res = @client.post("/webhooks/get", {webhook_id: webhook_id}.compact)

        Seam::Resources::Webhook.load_from_response(res.body["webhook"])
      end

      def list
        res = @client.post("/webhooks/list")

        Seam::Resources::Webhook.load_from_response(res.body["webhooks"])
      end

      def update(event_types:, webhook_id:)
        @client.post("/webhooks/update", {event_types: event_types, webhook_id: webhook_id}.compact)

        nil
      end
    end
  end
end
