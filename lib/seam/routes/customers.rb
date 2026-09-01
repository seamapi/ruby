# frozen_string_literal: true

require "seam/response"

module Seam
  module Clients
    class Customers
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Creates a new customer portal magic link with configurable features.
      # @param customer_data [Hash, nil]
      # @param customer_resources_filters [Array<Hash>, nil] Filter configuration for resources based on their custom_metadata. Each filter specifies a field, operation, and value to match against resource custom_metadata.
      # @param customization_profile_id [String, nil] The ID of the customization profile to use for the portal.
      # @param deep_link [Hash, nil] Deep link target resource for initial redirect. When set, the portal will navigate directly to the specified resource.
      # @param exclude_locale_picker [Boolean, nil] Whether to exclude the option to select a locale within the portal UI.
      # @param features [Hash, nil]
      # @param is_embedded [Boolean, nil] Whether the portal is embedded in another application.
      # @param landing_page [Hash, nil] Configuration for the landing page when the portal loads.
      # @param locale [String, nil] The locale to use for the portal.
      # @param navigation_mode [String, nil] Navigation mode for the portal. 'restricted' tells frontend to hide navigation UI, typically used for embedded deep links.
      # @param read_only [Boolean, nil] Whether the portal is read-only. When true, the customer can browse the portal but cannot perform any mutating action; write requests made with the portal's client session are rejected.
      # @return [Seam::Resources::CustomerPortal] OK
      def create_portal(customer_data: nil, customer_resources_filters: nil, customization_profile_id: nil, deep_link: nil, exclude_locale_picker: nil, features: nil, is_embedded: nil, landing_page: nil, locale: nil, navigation_mode: nil, read_only: nil)
        res = @client.post("/customers/create_portal", {customer_data: customer_data, customer_resources_filters: customer_resources_filters, customization_profile_id: customization_profile_id, deep_link: deep_link, exclude_locale_picker: exclude_locale_picker, features: features, is_embedded: is_embedded, landing_page: landing_page, locale: locale, navigation_mode: navigation_mode, read_only: read_only}.compact)

        Seam::Resources::CustomerPortal.load_from_response(Seam::Http::Response.read(res, "customer_portal", "/customers/create_portal"))
      end

      # Deletes customer data including resources like spaces, properties, rooms, users, etc.
      # This will delete the partner resources and any related Seam resources (user identities, access grants, spaces).
      # @param access_grant_keys [Array<String>, nil] List of access grant keys to delete.
      # @param booking_keys [Array<String>, nil] List of booking keys to delete.
      # @param building_keys [Array<String>, nil] List of building keys to delete.
      # @param common_area_keys [Array<String>, nil] List of common area keys to delete.
      # @param customer_keys [Array<String>, nil] List of customer keys to delete all data for.
      # @param facility_keys [Array<String>, nil] List of facility keys to delete.
      # @param guest_keys [Array<String>, nil] List of guest keys to delete.
      # @param listing_keys [Array<String>, nil] List of listing keys to delete.
      # @param property_keys [Array<String>, nil] List of property keys to delete.
      # @param property_listing_keys [Array<String>, nil] List of property listing keys to delete.
      # @param reservation_keys [Array<String>, nil] List of reservation keys to delete.
      # @param resident_keys [Array<String>, nil] List of resident keys to delete.
      # @param room_keys [Array<String>, nil] List of room keys to delete.
      # @param space_keys [Array<String>, nil] List of space keys to delete.
      # @param staff_member_keys [Array<String>, nil] List of staff member keys to delete.
      # @param tenant_keys [Array<String>, nil] List of tenant keys to delete.
      # @param unit_keys [Array<String>, nil] List of unit keys to delete.
      # @param user_identity_keys [Array<String>, nil] List of user identity keys to delete.
      # @param user_keys [Array<String>, nil] List of user keys to delete.
      # @return [nil] OK
      def delete_data(access_grant_keys: nil, booking_keys: nil, building_keys: nil, common_area_keys: nil, customer_keys: nil, facility_keys: nil, guest_keys: nil, listing_keys: nil, property_keys: nil, property_listing_keys: nil, reservation_keys: nil, resident_keys: nil, room_keys: nil, space_keys: nil, staff_member_keys: nil, tenant_keys: nil, unit_keys: nil, user_identity_keys: nil, user_keys: nil)
        @client.delete("/customers/delete_data", {access_grant_keys: access_grant_keys, booking_keys: booking_keys, building_keys: building_keys, common_area_keys: common_area_keys, customer_keys: customer_keys, facility_keys: facility_keys, guest_keys: guest_keys, listing_keys: listing_keys, property_keys: property_keys, property_listing_keys: property_listing_keys, reservation_keys: reservation_keys, resident_keys: resident_keys, room_keys: room_keys, space_keys: space_keys, staff_member_keys: staff_member_keys, tenant_keys: tenant_keys, unit_keys: unit_keys, user_identity_keys: user_identity_keys, user_keys: user_keys}.compact)

        nil
      end

      # Pushes customer data including resources like spaces, properties, rooms, users, etc.
      # @param customer_key [String] Your unique identifier for the customer.
      # @param access_grants [Array<Hash>, nil] List of access grants.
      # @param bookings [Array<Hash>, nil] List of bookings.
      # @param buildings [Array<Hash>, nil] List of buildings.
      # @param common_areas [Array<Hash>, nil] List of shared common areas.
      # @param facilities [Array<Hash>, nil] List of gym or fitness facilities.
      # @param guests [Array<Hash>, nil] List of guests.
      # @param listings [Array<Hash>, nil] List of property listings.
      # @param properties [Array<Hash>, nil] List of short-term rental properties.
      # @param property_listings [Array<Hash>, nil] List of property listings.
      # @param reservations [Array<Hash>, nil] List of reservations.
      # @param residents [Array<Hash>, nil] List of residents.
      # @param rooms [Array<Hash>, nil] List of hotel or hospitality rooms.
      # @param sites [Array<Hash>, nil] List of general sites or areas.
      # @param spaces [Array<Hash>, nil] List of general spaces or areas.
      # @param staff_members [Array<Hash>, nil] List of staff members.
      # @param tenants [Array<Hash>, nil] List of tenants.
      # @param units [Array<Hash>, nil] List of multi-family residential units.
      # @param user_identities [Array<Hash>, nil] List of user identities.
      # @param users [Array<Hash>, nil] List of users.
      # @return [nil] OK
      def push_data(customer_key:, access_grants: nil, bookings: nil, buildings: nil, common_areas: nil, facilities: nil, guests: nil, listings: nil, properties: nil, property_listings: nil, reservations: nil, residents: nil, rooms: nil, sites: nil, spaces: nil, staff_members: nil, tenants: nil, units: nil, user_identities: nil, users: nil)
        @client.post("/customers/push_data", {customer_key: customer_key, access_grants: access_grants, bookings: bookings, buildings: buildings, common_areas: common_areas, facilities: facilities, guests: guests, listings: listings, properties: properties, property_listings: property_listings, reservations: reservations, residents: residents, rooms: rooms, sites: sites, spaces: spaces, staff_members: staff_members, tenants: tenants, units: units, user_identities: user_identities, users: users}.compact)

        nil
      end
    end
  end
end
