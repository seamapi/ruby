# frozen_string_literal: true

module Seam
  module Resources
    class ThermostatSchedule < BaseResource
      attr_accessor :climate_preset_key, :device_id, :is_override_allowed, :max_override_period_minutes, :name, :thermostat_schedule_id, :workspace_id

      date_accessor :created_at, :ends_at, :starts_at

      include Seam::Resources::ResourceErrorsSupport
    end
  end
end
