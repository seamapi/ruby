# frozen_string_literal: true

module Seam
  module Clients
    class Customers
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Creates a new customer portal magic link with configurable features.
      # @param customer_resources_filters Filter configuration for resources based on their custom_metadata. Each filter specifies a field, operation, and value to match against resource custom_metadata.
      # @param customization_profile_id The ID of the customization profile to use for the portal.
      # @param deep_link Deep link target resource for initial redirect. When set, the portal will navigate directly to the specified resource.
      # @param exclude_locale_picker Whether to exclude the option to select a locale within the portal UI.
      # @param features
      # @param is_embedded Whether the portal is embedded in another application.
      # @param landing_page Configuration for the landing page when the portal loads.
      # @param locale The locale to use for the portal.
      # @param navigation_mode Navigation mode for the portal. 'restricted' tells frontend to hide navigation UI, typically used for embedded deep links.
      # @param read_only Whether the portal is read-only. When true, the customer can browse the portal but cannot perform any mutating action; write requests made with the portal's client session are rejected.
      # @param customer_data
      # @return [Seam::Resources::CustomerPortal] OK
      def create_portal(customer_resources_filters: nil, customization_profile_id: nil, deep_link: nil, exclude_locale_picker: nil, features: nil, is_embedded: nil, landing_page: nil, locale: nil, navigation_mode: nil, read_only: nil, customer_data: nil)
        res = @client.post("/customers/create_portal", {customer_resources_filters: customer_resources_filters, customization_profile_id: customization_profile_id, deep_link: deep_link, exclude_locale_picker: exclude_locale_picker, features: features, is_embedded: is_embedded, landing_page: landing_page, locale: locale, navigation_mode: navigation_mode, read_only: read_only, customer_data: customer_data}.compact)

        Seam::Resources::CustomerPortal.load_from_response(res.body["customer_portal"])
      end

      # Deletes customer data including resources like spaces, properties, rooms, users, etc.
      # This will delete the partner resources and any related Seam resources (user identities, access grants, spaces).
      # @param access_grant_keys List of access grant keys to delete.
      # @param booking_keys List of booking keys to delete.
      # @param building_keys List of building keys to delete.
      # @param common_area_keys List of common area keys to delete.
      # @param customer_keys List of customer keys to delete all data for.
      # @param facility_keys List of facility keys to delete.
      # @param guest_keys List of guest keys to delete.
      # @param listing_keys List of listing keys to delete.
      # @param property_keys List of property keys to delete.
      # @param property_listing_keys List of property listing keys to delete.
      # @param reservation_keys List of reservation keys to delete.
      # @param resident_keys List of resident keys to delete.
      # @param room_keys List of room keys to delete.
      # @param space_keys List of space keys to delete.
      # @param staff_member_keys List of staff member keys to delete.
      # @param tenant_keys List of tenant keys to delete.
      # @param unit_keys List of unit keys to delete.
      # @param user_identity_keys List of user identity keys to delete.
      # @param user_keys List of user keys to delete.
      # @return [nil] OK
      def delete_data(access_grant_keys: nil, booking_keys: nil, building_keys: nil, common_area_keys: nil, customer_keys: nil, facility_keys: nil, guest_keys: nil, listing_keys: nil, property_keys: nil, property_listing_keys: nil, reservation_keys: nil, resident_keys: nil, room_keys: nil, space_keys: nil, staff_member_keys: nil, tenant_keys: nil, unit_keys: nil, user_identity_keys: nil, user_keys: nil)
        @client.post("/customers/delete_data", {access_grant_keys: access_grant_keys, booking_keys: booking_keys, building_keys: building_keys, common_area_keys: common_area_keys, customer_keys: customer_keys, facility_keys: facility_keys, guest_keys: guest_keys, listing_keys: listing_keys, property_keys: property_keys, property_listing_keys: property_listing_keys, reservation_keys: reservation_keys, resident_keys: resident_keys, room_keys: room_keys, space_keys: space_keys, staff_member_keys: staff_member_keys, tenant_keys: tenant_keys, unit_keys: unit_keys, user_identity_keys: user_identity_keys, user_keys: user_keys}.compact)

        nil
      end

      # Pushes customer data including resources like spaces, properties, rooms, users, etc.
      # @param customer_key Your unique identifier for the customer.
      # @param access_grants List of access grants.
      # @param bookings List of bookings.
      # @param buildings List of buildings.
      # @param common_areas List of shared common areas.
      # @param facilities List of gym or fitness facilities.
      # @param guests List of guests.
      # @param listings List of property listings.
      # @param properties List of short-term rental properties.
      # @param property_listings List of property listings.
      # @param reservations List of reservations.
      # @param residents List of residents.
      # @param rooms List of hotel or hospitality rooms.
      # @param sites List of general sites or areas.
      # @param spaces List of general spaces or areas.
      # @param staff_members List of staff members.
      # @param tenants List of tenants.
      # @param units List of multi-family residential units.
      # @param user_identities List of user identities.
      # @param users List of users.
      # @return [nil] OK
      def push_data(customer_key:, access_grants: nil, bookings: nil, buildings: nil, common_areas: nil, facilities: nil, guests: nil, listings: nil, properties: nil, property_listings: nil, reservations: nil, residents: nil, rooms: nil, sites: nil, spaces: nil, staff_members: nil, tenants: nil, units: nil, user_identities: nil, users: nil)
        @client.post("/customers/push_data", {customer_key: customer_key, access_grants: access_grants, bookings: bookings, buildings: buildings, common_areas: common_areas, facilities: facilities, guests: guests, listings: listings, properties: properties, property_listings: property_listings, reservations: reservations, residents: residents, rooms: rooms, sites: sites, spaces: spaces, staff_members: staff_members, tenants: tenants, units: units, user_identities: user_identities, users: users}.compact)

        nil
      end
    end
  end
end
