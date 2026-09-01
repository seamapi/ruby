# frozen_string_literal: true

require "svix/webhook"
require "svix/errors"
# svix/webhook calls Svix.secure_compare without requiring the file defining it.
require "svix/util"
require_relative "base_resource"
require_relative "resources/event"

module Seam
  WebhookVerificationError = Svix::WebhookVerificationError

  # Raised when a payload is correctly signed but is not a Seam event. Unlike
  # WebhookVerificationError, retrying it can never help.
  class InvalidWebhookPayloadError < StandardError; end

  class Webhook
    def initialize(secret)
      @webhook = Svix::Webhook.new(secret)
    end

    # Known event types return a SeamEvent subclass; unknown types return a
    # generic SeamEvent for forward compatibility.
    #
    # @return [Seam::Resources::SeamEvent]
    # @raise [Seam::WebhookVerificationError] When the signature does not match.
    # @raise [Seam::InvalidWebhookPayloadError] When it does but the body is not an event.
    def verify(payload, headers)
      normalized_headers = headers.transform_keys(&:downcase)

      begin
        event_data = @webhook.verify(payload, normalized_headers)
      rescue JSON::ParserError => e
        raise InvalidWebhookPayloadError, "The verified webhook payload is not valid JSON: #{e.message}"
      end

      unless seam_event?(event_data)
        raise InvalidWebhookPayloadError, "The verified webhook payload did not contain a Seam event"
      end

      Seam::Resources::SeamEvent.load_from_response(event_data)
    end

    private

    # Svix parses with symbolize_names, so accept either key shape.
    def seam_event?(data)
      return false unless data.is_a?(Hash)

      %i[event_id event_type].all? do |key|
        (data[key] || data[key.to_s]).is_a?(String)
      end
    end
  end
end
