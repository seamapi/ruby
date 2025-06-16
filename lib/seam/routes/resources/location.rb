# frozen_string_literal: true

module Seam
  module Resources
    class Location < BaseResource
      attr_accessor :display_name, :geolocation, :location_id, :name, :time_zone, :workspace_id

      date_accessor :created_at
    end
  end
end
