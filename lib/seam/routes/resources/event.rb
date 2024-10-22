# frozen_string_literal: true

module Seam
  module Resources
    class SeamEvent < BaseResource
      attr_accessor :acs_credential_id, :acs_system_id, :acs_user_id, :action_attempt_id, :client_session_id, :climate_preset_key, :cooling_set_point_celsius, :cooling_set_point_fahrenheit, :device_id, :enrollment_automation_id, :event_description, :event_id, :event_type, :fan_mode_setting, :heating_set_point_celsius, :heating_set_point_fahrenheit, :hvac_mode_setting, :is_fallback_climate_preset, :method, :thermostat_schedule_id, :workspace_id

      date_accessor :created_at, :occurred_at
    end
  end
end
