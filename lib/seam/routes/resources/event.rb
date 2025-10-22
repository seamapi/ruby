# frozen_string_literal: true

module Seam
  module Resources
    class SeamEvent < BaseResource
      attr_accessor :access_code_id, :connected_account_custom_metadata, :connected_account_id, :device_custom_metadata, :device_id, :event_id, :event_type, :workspace_id, :code, :backup_access_code_id, :access_grant_id, :acs_entrance_id, :access_grant_key, :ends_at, :starts_at, :access_grant_ids, :access_grant_keys, :access_method_id, :is_backup_code, :acs_system_id, :acs_credential_id, :acs_user_id, :acs_encoder_id, :acs_access_group_id, :client_session_id, :connect_webview_id, :customer_key, :action_attempt_id, :action_type, :status, :error_code, :battery_level, :battery_status, :minut_metadata, :noise_level_decibels, :noise_level_nrs, :noise_threshold_id, :noise_threshold_name, :noiseaware_metadata, :method, :climate_preset_key, :is_fallback_climate_preset, :thermostat_schedule_id, :cooling_set_point_celsius, :cooling_set_point_fahrenheit, :fan_mode_setting, :heating_set_point_celsius, :heating_set_point_fahrenheit, :hvac_mode_setting, :lower_limit_celsius, :lower_limit_fahrenheit, :temperature_celsius, :temperature_fahrenheit, :upper_limit_celsius, :upper_limit_fahrenheit, :desired_temperature_celsius, :desired_temperature_fahrenheit, :device_name, :enrollment_automation_id, :acs_entrance_ids, :device_ids, :space_id, :space_key

      date_accessor :created_at, :occurred_at
    end
  end
end
