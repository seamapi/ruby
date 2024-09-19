# frozen_string_literal: true

require "svix"

module Seam
  class SeamWebhook
    def initialize(secret)
      @webhook = Svix::Webhook.new(secret)
    end

    def verify(payload, headers)
      normalized_headers = headers.transform_keys(&:downcase)
      res = @webhook.verify(payload, normalized_headers)

      Seam::Event.load_from_response(res)
    end
  end
end
