# frozen_string_literal: true

require "svix/webhook"
require "svix/errors"
# svix/webhook calls Svix.secure_compare but does not require the file defining
# it, so verification raises NoMethodError unless something else loaded it first.
require "svix/util"
require_relative "base_resource"
require_relative "resources/event"

module Seam
  WebhookVerificationError = Svix::WebhookVerificationError

  # Raised when a payload carries a valid signature but cannot be read as a Seam
  # event. Distinct from WebhookVerificationError: the sender is genuinely Seam,
  # so the payload will never become readable and retrying it cannot help.
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
    #   Respond with an error status so the sender retries.
    # @raise [Seam::InvalidWebhookPayloadError] When the signature matches but the
    #   body is not a Seam event. Report it rather than letting the sender retry.
    def verify(payload, headers)
      normalized_headers = headers.transform_keys(&:downcase)

      begin
        event_data = @webhook.verify(payload, normalized_headers)
      rescue JSON::ParserError => e
        # The signature already checked out, so this came from Seam but is
        # permanently unreadable.
        raise InvalidWebhookPayloadError, "The verified webhook payload is not valid JSON: #{e.message}"
      end

      unless seam_event?(event_data)
        raise InvalidWebhookPayloadError, "The verified webhook payload did not contain a Seam event"
      end

      Seam::Resources::SeamEvent.load_from_response(event_data)
    end

    private

    # Svix parses with symbolize_names, so read either key shape rather than
    # depending on how the payload happened to be decoded.
    def seam_event?(data)
      return false unless data.is_a?(Hash)

      %i[event_id event_type].all? do |key|
        (data[key] || data[key.to_s]).is_a?(String)
      end
    end
  end
end
