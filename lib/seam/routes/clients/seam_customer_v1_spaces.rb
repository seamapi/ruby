# frozen_string_literal: true

module Seam
  module Clients
    class SeamCustomerV1Spaces
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create(name:, acs_entrance_ids: nil, device_ids: nil, parent_space_key: nil, parent_space_name: nil, space_key: nil)
        res = @client.post("/seam/customer/v1/spaces/create", {name: name, acs_entrance_ids: acs_entrance_ids, device_ids: device_ids, parent_space_key: parent_space_key, parent_space_name: parent_space_name, space_key: space_key}.compact)

        Seam::Resources::Space.load_from_response(res.body["space"])
      end
    end
  end
end
