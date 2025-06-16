# frozen_string_literal: true

module Seam
  module Resources
    class ThermostatDailyProgram < BaseResource
      attr_accessor :device_id, :name, :periods, :thermostat_daily_program_id, :workspace_id

      date_accessor :created_at
    end
  end
end
