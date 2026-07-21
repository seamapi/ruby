# frozen_string_literal: true

module Seam
  module Resources
    class SeamEvent < BaseResource
      attr_accessor :access_code_errors, :access_code_id, :access_code_is_managed, :access_code_warnings, :access_grant_id, :access_grant_ids, :access_grant_key, :access_grant_keys, :access_method_id, :acs_access_group_id, :acs_credential_id, :acs_encoder_id, :acs_entrance_id, :acs_entrance_ids, :acs_system_errors, :acs_system_id, :acs_system_warnings, :acs_user_id, :action_attempt_id, :action_type, :activation_reason, :backup_access_code_id, :battery_level, :battery_status, :change_reason, :changed_properties, :client_session_id, :climate_preset_key, :code, :connect_webview_id, :connected_account_custom_metadata, :connected_account_errors, :connected_account_id, :connected_account_type, :connected_account_warnings, :cooling_set_point_celsius, :cooling_set_point_fahrenheit, :customer_key, :description, :desired_temperature_celsius, :desired_temperature_fahrenheit, :device_custom_metadata, :device_errors, :device_id, :device_ids, :device_name, :device_warnings, :ends_at, :enrollment_automation_id, :error_code, :error_message, :event_description, :event_id, :event_type, :fan_mode_setting, :from, :heating_set_point_celsius, :heating_set_point_fahrenheit, :hvac_mode_setting, :image_url, :is_backup_code, :is_fallback_climate_preset, :is_via_bluetooth, :is_via_nfc, :lower_limit_celsius, :lower_limit_fahrenheit, :method, :minut_metadata, :missing_device_ids, :motion_sub_type, :noise_level_decibels, :noise_level_nrs, :noise_threshold_id, :noise_threshold_name, :noiseaware_metadata, :reason, :requested_mutations, :space_id, :space_key, :starts_at, :status, :temperature_celsius, :temperature_fahrenheit, :thermostat_schedule_id, :to, :upper_limit_celsius, :upper_limit_fahrenheit, :user_identity_id, :video_url, :workspace_id

      date_accessor :created_at, :occurred_at
    end
  end
end
