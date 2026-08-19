# frozen_string_literal: true

module Seam
  module Clients
    class AccessGrants
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def unmanaged
        @unmanaged ||= Seam::Clients::AccessGrantsUnmanaged.new(client: @client, defaults: @defaults)
      end

      # Creates a new [Access Grant](https://docs.seam.co/use-cases/granting-access/access-grants). Access Grants are the default and recommended way to grant a user access to any physical space, irrespective of the locking hardware. They work with both standalone smart locks (using `device_ids`) and access control systems (using `acs_entrance_ids` or `space_ids`), and can issue PIN codes, key cards, and mobile keys through a single request.
      # @param requested_access_methods [Array<Hash>]
      # @param user_identity_id [String, nil] ID of user identity for whom access is being granted.
      # @param user_identity [Hash, nil] When used, creates a new user identity with the given details, and grants them access.
      # @param access_grant_key [String, nil] Unique key for the access grant within the workspace.
      # @param acs_entrance_ids [Array<String>, nil] Set of IDs of the [entrances](https://docs.seam.co/api/acs/systems/list) to which access is being granted.
      # @param customization_profile_id [String, nil] ID of the customization profile to apply to the Access Grant and its access methods.
      # @param device_ids [Array<String>, nil] Set of IDs of the [devices](https://docs.seam.co/api/devices/list) to which access is being granted.
      # @param ends_at [String, Seam::Null, nil] Date and time at which the validity of the new grant ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Must be a time in the future and after `starts_at`.
      # @param location [Hash, nil]
      # @deprecated location: Create a space first, then reference it using `space_ids`.
      # @param location_ids [Array<String>, nil]
      # @deprecated location_ids: Use `space_ids`.
      # @param name [String, Seam::Null, nil] Name for the access grant.
      # @param reservation_key [String, nil] Reservation key for the access grant.
      # @param space_ids [Array<String>, nil] Set of IDs of existing spaces to which access is being granted.
      # @param space_keys [Array<String>, nil] Set of keys of existing spaces to which access is being granted.
      # @param starts_at [String, nil] Date and time at which the validity of the new grant starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @return [Seam::Resources::AccessGrant] OK
      def create(requested_access_methods:, user_identity_id: nil, user_identity: nil, access_grant_key: nil, acs_entrance_ids: nil, customization_profile_id: nil, device_ids: nil, ends_at: nil, location: nil, location_ids: nil, name: nil, reservation_key: nil, space_ids: nil, space_keys: nil, starts_at: nil)
        res = @client.post("/access_grants/create", {requested_access_methods: requested_access_methods, user_identity_id: user_identity_id, user_identity: user_identity, access_grant_key: access_grant_key, acs_entrance_ids: acs_entrance_ids, customization_profile_id: customization_profile_id, device_ids: device_ids, ends_at: ends_at, location: location, location_ids: location_ids, name: name, reservation_key: reservation_key, space_ids: space_ids, space_keys: space_keys, starts_at: starts_at}.compact)

        Seam::Resources::AccessGrant.load_from_response(res.body["access_grant"])
      end

      # Delete an Access Grant.
      # @param access_grant_id [String] ID of Access Grant to delete.
      # @return [nil] OK
      def delete(access_grant_id:)
        @client.delete("/access_grants/delete", {access_grant_id: access_grant_id}.compact)

        nil
      end

      # Get an Access Grant.
      # @param access_grant_id [String, nil] ID of Access Grant to get.
      # @param access_grant_key [String, nil] Unique key of Access Grant to get.
      # @return [Seam::Resources::AccessGrant] OK
      def get(access_grant_id: nil, access_grant_key: nil)
        if access_grant_id.nil? && access_grant_key.nil?
          raise TypeError, "At least one parameter is required for /access_grants/get"
        end

        res = @client.get("/access_grants/get", {access_grant_id: access_grant_id, access_grant_key: access_grant_key}.compact)

        Seam::Resources::AccessGrant.load_from_response(res.body["access_grant"])
      end

      # Gets all related resources for one or more Access Grants.
      # @param access_grant_ids [Array<String>, nil] IDs of the access grants that you want to get along with their related resources.
      # @param access_grant_keys [Array<String>, nil] Keys of the access grants that you want to get along with their related resources.
      # @param exclude [Array<String>, nil]
      # @param include [Array<String>, nil]
      # @return [Seam::Resources::Batch] OK
      def get_related(access_grant_ids: nil, access_grant_keys: nil, exclude: nil, include: nil)
        if access_grant_ids.nil? && access_grant_keys.nil? && exclude.nil? && include.nil?
          raise TypeError, "At least one parameter is required for /access_grants/get_related"
        end

        res = @client.get("/access_grants/get_related", {access_grant_ids: access_grant_ids, access_grant_keys: access_grant_keys, exclude: exclude, include: include}.compact)

        Seam::Resources::Batch.load_from_response(res.body["batch"])
      end

      # Gets an Access Grant.
      # @param access_code_id [String, nil] ID of the access code by which you want to filter the list of Access Grants.
      # @param access_grant_ids [Array<String>, nil] IDs of the access grants to retrieve.
      # @param access_grant_key [String, Seam::Null, nil] Filter Access Grants by access_grant_key. Use null to filter for Access Grants without an access_grant_key.
      # @param acs_entrance_id [String, nil] ID of the entrance by which you want to filter the list of Access Grants.
      # @param acs_system_id [String, nil] ID of the access system by which you want to filter the list of Access Grants.
      # @param customer_key [String, nil] Customer key for which you want to list access grants.
      # @param device_id [String, nil] ID of the device by which you want to filter the list of Access Grants.
      # @param limit [Float, nil] Numerical limit on the number of access grants to return.
      # @param location_id [String, nil]
      # @deprecated location_id: Use `space_id`.
      # @param page_cursor [String, Seam::Null, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param reservation_key [String, nil] Filter Access Grants by reservation_key.
      # @param space_id [String, nil] ID of the space by which you want to filter the list of Access Grants.
      # @param user_identity_id [String, nil] ID of user identity by which you want to filter the list of Access Grants.
      # @return [Seam::Resources::AccessGrant] OK
      def list(access_code_id: nil, access_grant_ids: nil, access_grant_key: nil, acs_entrance_id: nil, acs_system_id: nil, customer_key: nil, device_id: nil, limit: nil, location_id: nil, page_cursor: nil, reservation_key: nil, space_id: nil, user_identity_id: nil)
        res = @client.get("/access_grants/list", {access_code_id: access_code_id, access_grant_ids: access_grant_ids, access_grant_key: access_grant_key, acs_entrance_id: acs_entrance_id, acs_system_id: acs_system_id, customer_key: customer_key, device_id: device_id, limit: limit, location_id: location_id, page_cursor: page_cursor, reservation_key: reservation_key, space_id: space_id, user_identity_id: user_identity_id}.compact)

        Seam::Resources::AccessGrant.load_from_response(res.body["access_grants"])
      end

      # Adds additional requested access methods to an existing Access Grant.
      # @param access_grant_id [String] ID of the Access Grant to add access methods to.
      # @param requested_access_methods [Array<Hash>] Array of requested access methods to add to the access grant.
      # @return [Seam::Resources::AccessGrant] OK
      def request_access_methods(access_grant_id:, requested_access_methods:)
        res = @client.post("/access_grants/request_access_methods", {access_grant_id: access_grant_id, requested_access_methods: requested_access_methods}.compact)

        Seam::Resources::AccessGrant.load_from_response(res.body["access_grant"])
      end

      # Updates an existing Access Grant's time window.
      # @param access_grant_id [String, nil] ID of the Access Grant to update. Provide either `access_grant_id` or `access_grant_key`.
      # @param access_grant_key [String, nil] Key of the Access Grant to update. Provide either `access_grant_id` or `access_grant_key`.
      # @param ends_at [Time, Seam::Null, nil] Date and time at which the validity of the grant ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Must be a time in the future and after `starts_at`.
      # @param name [String, Seam::Null, nil] Display name for the access grant.
      # @param starts_at [Time, nil] Date and time at which the validity of the grant starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @return [nil] OK
      def update(access_grant_id: nil, access_grant_key: nil, ends_at: nil, name: nil, starts_at: nil)
        if access_grant_id.nil? && access_grant_key.nil? && ends_at.nil? && name.nil? && starts_at.nil?
          raise TypeError, "At least one parameter is required for /access_grants/update"
        end

        @client.patch("/access_grants/update", {access_grant_id: access_grant_id, access_grant_key: access_grant_key, ends_at: ends_at, name: name, starts_at: starts_at}.compact)

        nil
      end
    end
  end
end
