# frozen_string_literal: true

module Seam
  module Resources
    # Represents a space that is a logical grouping of devices and entrances. You can assign access to an entire space, thereby making granting access more efficient.
    class Space < BaseResource
      # Number of entrances in the space.
      attr_accessor :acs_entrance_count
      # Reservation/stay-related defaults for the space. Also carries the provider/PMS-supplied name under a `<connector_type>_name` key (e.g. `guesty_name`), which Seam preserves when you rename the space (read-only — managed by Seam).
      attr_accessor :customer_data
      # Customer key associated with the space.
      attr_accessor :customer_key
      # Number of devices in the space.
      attr_accessor :device_count
      # Display name for the space.
      attr_accessor :display_name
      # Geographic coordinates (latitude and longitude) of the space.
      attr_accessor :geolocation
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
