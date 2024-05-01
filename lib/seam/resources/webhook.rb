# frozen_string_literal: true

module Seam
  class Webhook < BaseResource
    attr_accessor :event_types, :secret, :url, :webhook_id
  end
end
