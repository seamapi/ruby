# frozen_string_literal: true

require "svix"
require_relative "base_resource"
require_relative "resources/event"

module Seam
  WebhookVerificationError = Svix::WebhookVerificationError

  class Webhook
    def initialize(secret)
      @webhook = Svix::Webhook.new(secret)
    end

    # Known event types return a SeamEvent subclass; unknown types return a
    # generic SeamEvent for forward compatibility.
    # @return [Seam::Resources::SeamEvent]
    def verify(payload, headers)
      normalized_headers = headers.transform_keys(&:downcase)
      event_data = @webhook.verify(payload, normalized_headers)

      Seam::Resources::SeamEvent.load_from_response(event_data)
    end
  end
end
