# frozen_string_literal: true

require "json"
require "svix"
require_relative "base_resource"
require_relative "errors"
require_relative "resources/event"

module Seam
  WebhookVerificationError = Svix::WebhookVerificationError

  class InvalidWebhookPayloadError < Seam::Error
  end

  class Webhook
    def initialize(secret = ENV["SEAM_WEBHOOK_SECRET"])
      unless secret.is_a?(String)
        raise TypeError, "Webhook secret must be a string; pass it explicitly or set SEAM_WEBHOOK_SECRET"
      end
      if secret.empty?
        raise Svix::EmptyWebhookSecretError, "Pass a webhook secret or set SEAM_WEBHOOK_SECRET to a non-empty value"
      end

      @webhook = Svix::Webhook.new(secret)
    end

    # Known event types return a SeamEvent subclass; unknown types return a
    # generic SeamEvent for forward compatibility.
    # @return [Seam::Resources::SeamEvent]
    def verify(payload, headers)
      normalized_headers = headers.transform_keys { |key| key.to_s.downcase }

      event_data = begin
        @webhook.verify(payload, normalized_headers)
      rescue JSON::ParserError => error
        raise InvalidWebhookPayloadError, "The verified webhook payload is not valid JSON: #{error.message}"
      end

      unless event_data.is_a?(Hash) && event_data[:event_id].is_a?(String) && event_data[:event_type].is_a?(String)
        raise InvalidWebhookPayloadError, "The verified webhook payload did not contain a Seam event"
      end

      Seam::Resources::SeamEvent.load_from_response(event_data)
    end
  end
end
