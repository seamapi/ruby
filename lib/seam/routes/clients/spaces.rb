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

      def create(name:, acs_entrance_ids: nil, device_ids: nil, space_key: nil)
        res = @client.post("/spaces/create", {name: name, acs_entrance_ids: acs_entrance_ids, device_ids: device_ids, space_key: space_key}.compact)

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

      def get_related(space_ids:, exclude: nil, include: nil)
        @client.post("/spaces/get_related", {space_ids: space_ids, exclude: exclude, include: include}.compact)

        nil
      end

      def list(connected_account_id: nil, search: nil, space_key: nil)
        res = @client.post("/spaces/list", {connected_account_id: connected_account_id, search: search, space_key: space_key}.compact)

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

      def update(space_id:, name: nil)
        res = @client.post("/spaces/update", {space_id: space_id, name: name}.compact)

        Seam::Resources::Space.load_from_response(res.body["space"])
      end
    end
  end
end
