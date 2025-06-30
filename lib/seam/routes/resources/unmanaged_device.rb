# frozen_string_literal: true

module Seam
  module Resources
    class UnmanagedDevice < BaseResource
      attr_accessor :can_hvac_cool, :can_hvac_heat, :can_hvac_heat_cool, :can_program_offline_access_codes, :can_program_online_access_codes, :can_remotely_lock, :can_remotely_unlock, :can_simulate_connection, :can_simulate_disconnection, :can_simulate_removal, :can_turn_off_hvac, :can_unlock_with_code, :capabilities_supported, :connected_account_id, :device_id, :device_type, :is_managed, :location, :properties, :workspace_id

      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
