# frozen_string_literal: true

module Seam
  module Clients
    class Webhooks < BaseClient
      def create(url:, event_types: nil)
        request_seam_object(
          :post,
          "/webhooks/create",
          Seam::Resources::Webhook,
          "webhook",
          body: {url: url, event_types: event_types}.compact
        )
      end

      def delete(webhook_id:)
        request_seam(
          :post,
          "/webhooks/delete",
          body: {webhook_id: webhook_id}.compact
        )

        nil
      end

      def get(webhook_id:)
        request_seam_object(
          :post,
          "/webhooks/get",
          Seam::Resources::Webhook,
          "webhook",
          body: {webhook_id: webhook_id}.compact
        )
      end

      def list
        request_seam_object(
          :post,
          "/webhooks/list",
          Seam::Resources::Webhook,
          "webhooks",
          body: {}.compact
        )
      end

      def update(event_types:, webhook_id:)
        request_seam(
          :post,
          "/webhooks/update",
          body: {event_types: event_types, webhook_id: webhook_id}.compact
        )

        nil
      end
    end
  end
end
