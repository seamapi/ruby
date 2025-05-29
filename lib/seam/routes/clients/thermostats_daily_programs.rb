# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class ThermostatsDailyPrograms
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create(device_id:, name:, periods:)
        @client.post("/thermostats/daily_programs/create", {device_id: device_id, name: name, periods: periods}.compact)

        nil
      end

      def delete(thermostat_daily_program_id:)
        @client.post("/thermostats/daily_programs/delete", {thermostat_daily_program_id: thermostat_daily_program_id}.compact)

        nil
      end

      def update(name:, periods:, thermostat_daily_program_id:, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/daily_programs/update", {name: name, periods: periods, thermostat_daily_program_id: thermostat_daily_program_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end
    end
  end
end
