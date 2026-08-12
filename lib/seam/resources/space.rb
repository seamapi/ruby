# frozen_string_literal: true

module Seam
  module Resources
    # Represents a space that is a logical grouping of devices and entrances. You can assign access to an entire space, thereby making granting access more efficient.
    class Space < BaseResource
      class CustomerData < BaseResource
        # Postal address for the space.
        attr_accessor :address
        # Default check-in time for reservations at the space, as HH:mm or HH:mm:ss.
        attr_accessor :default_checkin_time
        # Default check-out time for reservations at the space, as HH:mm or HH:mm:ss.
        attr_accessor :default_checkout_time
        # IANA time zone for the space, e.g. America/Los_Angeles.
        attr_accessor :time_zone
      end

      class Geolocation < BaseResource
        # Latitude of the space, in decimal degrees.
        attr_accessor :latitude
        # Longitude of the space, in decimal degrees.
        attr_accessor :longitude
      end

      resource_accessor :customer_data, CustomerData
      resource_accessor :geolocation, Geolocation
      # Number of entrances in the space.
      attr_accessor :acs_entrance_count
      # Customer key associated with the space.
      attr_accessor :customer_key
      # Number of devices in the space.
      attr_accessor :device_count
      # Display name for the space.
      attr_accessor :display_name
      # Name of the space.
      attr_accessor :name
      # ID of the space.
      attr_accessor :space_id
      # Unique key for the space within the workspace.
      attr_accessor :space_key
      # ID of the workspace associated with the space.
      attr_accessor :workspace_id

      # Date and time at which the space was created.
      date_accessor :created_at
    end
  end
end
