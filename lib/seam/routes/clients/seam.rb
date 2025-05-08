# frozen_string_literal: true

module Seam
  module Clients
    class Seam
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def instant_key
        @instant_key ||= Seam::Clients::SeamInstantKey.new(client: @client, defaults: @defaults)
      end
    end
  end
end
