# frozen_string_literal: true

module Seam
  module Clients
    class Cameras
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def live_views
        @live_views ||= Seam::Clients::CamerasLiveViews.new(client: @client, defaults: @defaults)
      end
    end
  end
end
