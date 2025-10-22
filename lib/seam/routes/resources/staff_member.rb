# frozen_string_literal: true

module Seam
  module Resources
    class StaffMember < BaseResource
      attr_accessor :building_keys, :common_area_keys, :email_address, :facility_keys, :listing_keys, :name, :phone_number, :property_keys, :property_listing_keys, :room_keys, :site_keys, :space_keys, :staff_member_key, :unit_keys
    end
  end
end
