# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [webhook](https://docs.seam.co/developer-tools/webhooks) that enables you to receive notifications of events. When you create a webhook, specify the endpoint URL at which you want to receive events and the set of event types that you want to receive.
    class Webhook < BaseResource
      # Types of events that the [webhook](https://docs.seam.co/developer-tools/webhooks) should receive.
      attr_accessor :event_types
      # Secret associated with the [webhook](https://docs.seam.co/developer-tools/webhooks).
      attr_accessor :secret
      # URL for the [webhook](https://docs.seam.co/developer-tools/webhooks).
      attr_accessor :url
      # ID of the webhook.
      attr_accessor :webhook_id
    end
  end
end
