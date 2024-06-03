# frozen_string_literal: true

module Seam
  class ClimateSettingSchedule < BaseResource
    attr_accessor :automatic_cooling_enabled, :automatic_heating_enabled, :climate_setting_schedule_id, :cooling_set_point_celsius, :cooling_set_point_fahrenheit, :device_id, :heating_set_point_celsius, :heating_set_point_fahrenheit, :hvac_mode_setting, :manual_override_allowed, :name, :schedule_ends_at, :schedule_starts_at, :schedule_type

    date_accessor :created_at

    include Seam::ResourceErrorsSupport
  end
end
