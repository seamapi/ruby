# frozen_string_literal: true

module Seam
  class Phone < BaseResource
    attr_accessor :can_hvac_cool, :can_hvac_heat, :can_hvac_heat_cool, :can_program_offline_access_codes, :can_program_online_access_codes, :can_remotely_lock, :can_remotely_unlock, :can_simulate_connection, :can_simulate_disconnection, :can_simulate_removal, :can_turn_off_hvac, :capabilities_supported, :custom_metadata, :device_id, :device_type, :display_name, :is_managed, :location, :nickname, :properties, :workspace_id

    date_accessor :created_at

    include Seam::ResourceErrorsSupport
    include Seam::ResourceWarningsSupport
  end
end
