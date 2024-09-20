# frozen_string_literal: true

module Seam
  class ClimatePreset < BaseResource
    attr_accessor :can_delete, :can_edit, :climate_preset_key, :cooling_set_point_celsius, :cooling_set_point_fahrenheit, :display_name, :fan_mode_setting, :heating_set_point_celsius, :heating_set_point_fahrenheit, :hvac_mode_setting, :manual_override_allowed, :name
  end
end
