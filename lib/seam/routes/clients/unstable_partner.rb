# frozen_string_literal: true

module Seam
  module Clients
    class UnstablePartner
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def building_blocks
        @building_blocks ||= Seam::Clients::UnstablePartnerBuildingBlocks.new(client: @client, defaults: @defaults)
      end
    end
  end
end
