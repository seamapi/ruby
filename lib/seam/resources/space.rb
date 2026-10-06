# frozen_string_literal: true

module Seam
  module Resources
    # Represents a space that is a logical grouping of devices and entrances. You can assign access to an entire space, thereby making granting access more efficient.
    class Space < BaseResource
      class CustomerData < BaseResource
        # Postal address for the space.
        # @return [String, nil]
        attr_accessor :address
        # Default check-in time for reservations at the space, as HH:mm or HH:mm:ss.
        # @return [String, nil]
        attr_accessor :default_checkin_time
        # Default check-out time for reservations at the space, as HH:mm or HH:mm:ss.
        # @return [String, nil]
        attr_accessor :default_checkout_time
        # IANA time zone for the space, e.g. America/Los_Angeles.
        # @return [String, nil]
        attr_accessor :time_zone
      end

      class Geolocation < BaseResource
        # Latitude of the space, in decimal degrees.
        # @return [Float]
        attr_accessor :latitude
        # Longitude of the space, in decimal degrees.
        # @return [Float]
        attr_accessor :longitude
      end

      # Known `warning_code` values load as subclasses; unknown values remain Warnings instances for forward compatibility.
      class Warnings < BaseResource
        # Indicates that the space is being deleted. Seam removes it, revokes its access grants, and detaches its devices and entrances shortly.
        class BeingDeleted < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `being_deleted`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        # @return [String]
        # Known values:
        # - `being_deleted`
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :warning_code, {
          "being_deleted" => BeingDeleted
        }.freeze
      end

      # Reservation/stay-related defaults for the space. Also carries the provider/PMS-supplied name under a `<connector_type>_name` key (e.g. `guesty_name`), which Seam preserves when you rename the space (read-only — managed by Seam).
      # @return [CustomerData, nil]
      resource_accessor :customer_data, CustomerData
      # Geographic coordinates (latitude and longitude) of the space.
      # @return [Geolocation, nil]
      resource_accessor :geolocation, Geolocation
      # Warnings associated with the space.
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # Number of entrances in the space.
      # @return [Float]
      attr_accessor :acs_entrance_count
      # Customer key associated with the space.
      # @return [String, nil]
      attr_accessor :customer_key
      # Number of devices in the space.
      # @return [Float]
      attr_accessor :device_count
      # Display name for the space.
      # @return [String]
      attr_accessor :display_name
      # Name of the space.
      # @return [String]
      attr_accessor :name
      # ID of the space.
      # @return [String]
      attr_accessor :space_id
      # Unique key for the space within the workspace.
      # @return [String, nil]
      attr_accessor :space_key
      # ID of the workspace associated with the space.
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the space was created.
      # @return [Time]
      date_accessor :created_at
    end
  end
end
