# frozen_string_literal: true

module Seam
  module Clients
    class Spaces
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Adds [entrances](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) to a specific space.
      # @param acs_entrance_ids IDs of the entrances that you want to add to the space.
      # @param space_id ID of the space to which you want to add entrances.
      # @return [nil] OK
      def add_acs_entrances(acs_entrance_ids:, space_id:)
        @client.post("/spaces/add_acs_entrances", {acs_entrance_ids: acs_entrance_ids, space_id: space_id}.compact)

        nil
      end

      # Adds a [connected account](https://docs.seam.co/core-concepts/connected-accounts) to a specific space.
      # @param connected_account_id ID of the connected account that you want to add to the space.
      # @param space_id ID of the space to which you want to add the connected account.
      # @return [nil] OK
      def add_connected_account(connected_account_id:, space_id:)
        @client.post("/spaces/add_connected_account", {connected_account_id: connected_account_id, space_id: space_id}.compact)

        nil
      end

      # Adds devices to a specific space.
      # @param device_ids IDs of the devices that you want to add to the space.
      # @param space_id ID of the space to which you want to add devices.
      # @return [nil] OK
      def add_devices(device_ids:, space_id:)
        @client.post("/spaces/add_devices", {device_ids: device_ids, space_id: space_id}.compact)

        nil
      end

      # Creates a new space.
      # @param name Name of the space that you want to create.
      # @param acs_entrance_ids IDs of the entrances that you want to add to the new space.
      # @param connected_account_ids IDs of connected accounts to associate with the new space. Persisted on seam.location_third_party_account so the UI can show which provider account(s) a space came from.
      # @param customer_data Reservation/stay-related defaults for the space.
      # @param customer_key Customer key for which you want to create the space.
      # @param device_ids IDs of the devices that you want to add to the new space.
      # @param space_key Unique key for the space within the workspace.
      # @return [Seam::Resources::Space] OK
      def create(name:, acs_entrance_ids: nil, connected_account_ids: nil, customer_data: nil, customer_key: nil, device_ids: nil, space_key: nil)
        res = @client.post("/spaces/create", {name: name, acs_entrance_ids: acs_entrance_ids, connected_account_ids: connected_account_ids, customer_data: customer_data, customer_key: customer_key, device_ids: device_ids, space_key: space_key}.compact)

        Seam::Resources::Space.load_from_response(res.body["space"])
      end

      # Deletes a space.
      # @param space_id ID of the space that you want to delete.
      # @return [nil] OK
      def delete(space_id:)
        @client.post("/spaces/delete", {space_id: space_id}.compact)

        nil
      end

      # Gets a space.
      # @param space_id ID of the space that you want to get.
      # @param space_key Unique key of the space that you want to get.
      # @return [Seam::Resources::Space] OK
      def get(space_id: nil, space_key: nil)
        res = @client.post("/spaces/get", {space_id: space_id, space_key: space_key}.compact)

        Seam::Resources::Space.load_from_response(res.body["space"])
      end

      # Gets all related resources for one or more Spaces.
      # @param exclude
      # @param include
      # @param space_ids IDs of the spaces that you want to get along with their related resources.
      # @param space_keys Keys of the spaces that you want to get along with their related resources.
      # @return [Seam::Resources::Batch] OK
      def get_related(exclude: nil, include: nil, space_ids: nil, space_keys: nil)
        res = @client.post("/spaces/get_related", {exclude: exclude, include: include, space_ids: space_ids, space_keys: space_keys}.compact)

        Seam::Resources::Batch.load_from_response(res.body["batch"])
      end

      # Returns a list of all spaces.
      # @param customer_key Customer key for which you want to list spaces.
      # @param limit Maximum number of records to return per page.
      # @param page_cursor Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search String for which to search. Filters returned spaces to include all records that satisfy a partial match using `name`, `space_key`, or `customer_key`.
      # @param space_key Filter spaces by space_key.
      # @return [Seam::Resources::Space] OK
      def list(customer_key: nil, limit: nil, page_cursor: nil, search: nil, space_key: nil)
        res = @client.post("/spaces/list", {customer_key: customer_key, limit: limit, page_cursor: page_cursor, search: search, space_key: space_key}.compact)

        Seam::Resources::Space.load_from_response(res.body["spaces"])
      end

      # Removes [entrances](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) from a specific space.
      # @param acs_entrance_ids IDs of the entrances that you want to remove from the space.
      # @param space_id ID of the space from which you want to remove entrances.
      # @return [nil] OK
      def remove_acs_entrances(acs_entrance_ids:, space_id:)
        @client.post("/spaces/remove_acs_entrances", {acs_entrance_ids: acs_entrance_ids, space_id: space_id}.compact)

        nil
      end

      # Removes a [connected account](https://docs.seam.co/core-concepts/connected-accounts) from a specific space.
      # @param connected_account_id ID of the connected account that you want to remove from the space.
      # @param space_id ID of the space from which you want to remove the connected account.
      # @return [nil] OK
      def remove_connected_account(connected_account_id:, space_id:)
        @client.post("/spaces/remove_connected_account", {connected_account_id: connected_account_id, space_id: space_id}.compact)

        nil
      end

      # Removes devices from a specific space.
      # @param device_ids IDs of the devices that you want to remove from the space.
      # @param space_id ID of the space from which you want to remove devices.
      # @return [nil] OK
      def remove_devices(device_ids:, space_id:)
        @client.post("/spaces/remove_devices", {device_ids: device_ids, space_id: space_id}.compact)

        nil
      end

      # Updates an existing space.
      # @param acs_entrance_ids IDs of the entrances that you want to set for the space. If specified, this will replace all existing entrances.
      # @param customer_data Reservation/stay-related defaults for the space. Only the keys you provide are updated; omit a key to leave it unchanged. Pass null on a key to clear it.
      # @param device_ids IDs of the devices that you want to set for the space. If specified, this will replace all existing devices.
      # @param name Name of the space.
      # @param space_id ID of the space that you want to update.
      # @param space_key Unique key of the space that you want to update.
      # @return [Seam::Resources::Space] OK
      def update(acs_entrance_ids: nil, customer_data: nil, device_ids: nil, name: nil, space_id: nil, space_key: nil)
        res = @client.post("/spaces/update", {acs_entrance_ids: acs_entrance_ids, customer_data: customer_data, device_ids: device_ids, name: name, space_id: space_id, space_key: space_key}.compact)

        Seam::Resources::Space.load_from_response(res.body["space"])
      end
    end
  end
end
