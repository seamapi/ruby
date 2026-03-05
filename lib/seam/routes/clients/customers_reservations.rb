# frozen_string_literal: true

module Seam
  module Clients
    class CustomersReservations
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create_deep_link(customer_key:, reservation_key:)
        @client.post("/customers/reservations/create_deep_link", {customer_key: customer_key, reservation_key: reservation_key}.compact)

        nil
      end
    end
  end
end
