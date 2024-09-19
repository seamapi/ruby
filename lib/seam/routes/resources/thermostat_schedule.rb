# frozen_string_literal: true

module Seam
  class ThermostatSchedule < BaseResource
    attr_accessor :climate_preset_key, :device_id, :max_override_period_minutes, :name, :thermostat_schedule_id

    date_accessor :created_at, :ends_at, :starts_at

    include Seam::ResourceErrorsSupport
  end
end
