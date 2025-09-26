# frozen_string_literal: true

module Seam
  module Clients
    class Customers
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create_portal(features: nil, is_embedded: nil, landing_page: nil, customer_data: nil)
        res = @client.post("/customers/create_portal", {features: features, is_embedded: is_embedded, landing_page: landing_page, customer_data: customer_data}.compact)

        Seam::Resources::MagicLink.load_from_response(res.body["magic_link"])
      end

      def delete_data(access_grant_keys: nil, booking_keys: nil, building_keys: nil, common_area_keys: nil, customer_keys: nil, facility_keys: nil, guest_keys: nil, listing_keys: nil, property_keys: nil, property_listing_keys: nil, reservation_keys: nil, resident_keys: nil, room_keys: nil, space_keys: nil, tenant_keys: nil, unit_keys: nil, user_identity_keys: nil, user_keys: nil)
        @client.post("/customers/delete_data", {access_grant_keys: access_grant_keys, booking_keys: booking_keys, building_keys: building_keys, common_area_keys: common_area_keys, customer_keys: customer_keys, facility_keys: facility_keys, guest_keys: guest_keys, listing_keys: listing_keys, property_keys: property_keys, property_listing_keys: property_listing_keys, reservation_keys: reservation_keys, resident_keys: resident_keys, room_keys: room_keys, space_keys: space_keys, tenant_keys: tenant_keys, unit_keys: unit_keys, user_identity_keys: user_identity_keys, user_keys: user_keys}.compact)

        nil
      end

      def push_data(customer_key:, access_grants: nil, bookings: nil, buildings: nil, common_areas: nil, facilities: nil, guests: nil, listings: nil, properties: nil, property_listings: nil, reservations: nil, residents: nil, rooms: nil, sites: nil, spaces: nil, tenants: nil, units: nil, user_identities: nil, users: nil)
        @client.post("/customers/push_data", {customer_key: customer_key, access_grants: access_grants, bookings: bookings, buildings: buildings, common_areas: common_areas, facilities: facilities, guests: guests, listings: listings, properties: properties, property_listings: property_listings, reservations: reservations, residents: residents, rooms: rooms, sites: sites, spaces: spaces, tenants: tenants, units: units, user_identities: user_identities, users: users}.compact)

        nil
      end
    end
  end
end
