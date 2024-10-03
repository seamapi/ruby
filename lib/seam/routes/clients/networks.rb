# frozen_string_literal: true

module Seam
  module Clients
    class Networks < BaseClient
      def get(network_id:)
        request_seam_object(
          :post,
          "/networks/get",
          Seam::Resources::Network,
          "network",
          body: {network_id: network_id}.compact
        )
      end

      def list
        request_seam_object(
          :post,
          "/networks/list",
          Seam::Resources::Network,
          "networks",
          body: {}.compact
        )
      end
    end
  end
end
