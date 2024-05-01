# frozen_string_literal: true

module Seam
  module Clients
    class Networks < BaseClient
      def get(network_id:)
        request_seam_object(
          :post,
          "/networks/get",
          Seam::Network,
          "network",
          body: {network_id: network_id}.compact
        )
      end

      def list
        request_seam_object(
          :post,
          "/networks/list",
          Seam::Network,
          "networks",
          body: {}.compact
        )
      end
    end
  end
end
