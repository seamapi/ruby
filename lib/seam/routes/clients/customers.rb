# frozen_string_literal: true

module Seam
  module Clients
    class Customers
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create_portal(features: nil, is_embedded: nil, customer_data: nil)
        res = @client.post("/customers/create_portal", {features: features, is_embedded: is_embedded, customer_data: customer_data}.compact)

        Seam::Resources::MagicLink.load_from_response(res.body["magic_link"])
      end

      def push_data(customer_key:, access_grants: nil, bookings: nil, buildings: nil, common_areas: nil, facilities: nil, guests: nil, listings: nil, properties: nil, property_listings: nil, reservations: nil, residents: nil, rooms: nil, spaces: nil, tenants: nil, units: nil, user_identities: nil, users: nil)
        @client.post("/customers/push_data", {customer_key: customer_key, access_grants: access_grants, bookings: bookings, buildings: buildings, common_areas: common_areas, facilities: facilities, guests: guests, listings: listings, properties: properties, property_listings: property_listings, reservations: reservations, residents: residents, rooms: rooms, spaces: spaces, tenants: tenants, units: units, user_identities: user_identities, users: users}.compact)

        nil
      end
    end
  end
end
