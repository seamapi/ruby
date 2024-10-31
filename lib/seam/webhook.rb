# frozen_string_literal: true

require "svix"
require_relative "base_resource"
require_relative "routes/resources/event"

module Seam
  WebhookVerificationError = Svix::WebhookVerificationError

  class Webhook
    def initialize(secret)
      @webhook = Svix::Webhook.new(secret)
    end

    def verify(payload, headers)
      normalized_headers = headers.transform_keys(&:downcase)
      res = @webhook.verify(payload, normalized_headers)

      Seam::Resources::SeamEvent.load_from_response(res)
    end
  end
end
