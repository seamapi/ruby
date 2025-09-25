# frozen_string_literal: true

module Seam
  module Clients
    class Spaces
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def add_acs_entrances(acs_entrance_ids:, space_id:)
        @client.post("/spaces/add_acs_entrances", {acs_entrance_ids: acs_entrance_ids, space_id: space_id}.compact)

        nil
      end

      def add_devices(device_ids:, space_id:)
        @client.post("/spaces/add_devices", {device_ids: device_ids, space_id: space_id}.compact)

        nil
      end

      def create(name:, acs_entrance_ids: nil, customer_key: nil, device_ids: nil, space_key: nil)
        res = @client.post("/spaces/create", {name: name, acs_entrance_ids: acs_entrance_ids, customer_key: customer_key, device_ids: device_ids, space_key: space_key}.compact)

        Seam::Resources::Space.load_from_response(res.body["space"])
      end

      def delete(space_id:)
        @client.post("/spaces/delete", {space_id: space_id}.compact)

        nil
      end

      def get(space_id: nil, space_key: nil)
        res = @client.post("/spaces/get", {space_id: space_id, space_key: space_key}.compact)

        Seam::Resources::Space.load_from_response(res.body["space"])
      end

      def get_related(exclude: nil, include: nil, space_ids: nil, space_keys: nil)
        @client.post("/spaces/get_related", {exclude: exclude, include: include, space_ids: space_ids, space_keys: space_keys}.compact)

        nil
      end

      def list(connected_account_id: nil, customer_key: nil, search: nil, space_key: nil)
        res = @client.post("/spaces/list", {connected_account_id: connected_account_id, customer_key: customer_key, search: search, space_key: space_key}.compact)

        Seam::Resources::Space.load_from_response(res.body["spaces"])
      end

      def remove_acs_entrances(acs_entrance_ids:, space_id:)
        @client.post("/spaces/remove_acs_entrances", {acs_entrance_ids: acs_entrance_ids, space_id: space_id}.compact)

        nil
      end

      def remove_devices(device_ids:, space_id:)
        @client.post("/spaces/remove_devices", {device_ids: device_ids, space_id: space_id}.compact)

        nil
      end

      def update(acs_entrance_ids: nil, customer_key: nil, device_ids: nil, name: nil, space_id: nil, space_key: nil)
        res = @client.post("/spaces/update", {acs_entrance_ids: acs_entrance_ids, customer_key: customer_key, device_ids: device_ids, name: name, space_id: space_id, space_key: space_key}.compact)

        Seam::Resources::Space.load_from_response(res.body["space"])
      end
    end
  end
end
