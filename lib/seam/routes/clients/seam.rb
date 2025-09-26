# frozen_string_literal: true

module Seam
  module Clients
    class Seam
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def customer
        @customer ||= Seam::Clients::SeamCustomer.new(client: @client, defaults: @defaults)
      end
    end
  end
end
