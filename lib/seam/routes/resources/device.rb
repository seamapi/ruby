# frozen_string_literal: true

module Seam
  module Resources
    class Device < BaseResource
      attr_accessor :can_hvac_cool, :can_hvac_heat, :can_hvac_heat_cool, :can_program_offline_access_codes, :can_program_online_access_codes, :can_program_thermostat_programs_as_different_each_day, :can_program_thermostat_programs_as_same_each_day, :can_program_thermostat_programs_as_weekday_weekend, :can_remotely_lock, :can_remotely_unlock, :can_run_thermostat_programs, :can_simulate_connection, :can_simulate_disconnection, :can_simulate_hub_connection, :can_simulate_hub_disconnection, :can_simulate_paid_subscription, :can_simulate_removal, :can_turn_off_hvac, :can_unlock_with_code, :capabilities_supported, :connected_account_id, :custom_metadata, :device_id, :device_type, :display_name, :is_managed, :location, :nickname, :properties, :space_ids, :workspace_id

      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
