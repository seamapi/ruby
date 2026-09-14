# frozen_string_literal: true

require "seam/response"
require "seam/action_attempt_resolver"

module Seam
  module Clients
    class ThermostatsDailyPrograms
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Creates a new thermostat daily program. A daily program consists of a set of periods, where each period includes a start time and the key of a configured climate preset. Once you have defined a daily program, you can assign it to one or more days within a weekly program.
      # @param device_id [String] ID of the thermostat device for which you want to create a daily program.
      # @param name [String] Name of the thermostat daily program.
      # @param periods [Array<Hash>] Array of thermostat daily program periods.
      # @return [Seam::Resources::ThermostatDailyProgram] OK
      def create(device_id:, name:, periods:)
        res = @client.post("/thermostats/daily_programs/create", {device_id: device_id, name: name, periods: periods}.compact)

        Seam::Resources::ThermostatDailyProgram.load_from_response(Seam::Http::Response.read(res, "thermostat_daily_program", "/thermostats/daily_programs/create"))
      end

      # Deletes a thermostat daily program.
      # @param thermostat_daily_program_id [String] ID of the thermostat daily program that you want to delete.
      # @return [nil] OK
      def delete(thermostat_daily_program_id:)
        @client.delete("/thermostats/daily_programs/delete", {thermostat_daily_program_id: thermostat_daily_program_id}.compact)

        nil
      end

      # Updates a specified thermostat daily program. The periods that you specify overwrite any existing periods for the daily program.
      # @param name [String] Name of the thermostat daily program that you want to update.
      # @param periods [Array<Hash>] Array of thermostat daily program periods. The periods that you specify overwrite any existing periods for the daily program.
      # @param thermostat_daily_program_id [String] ID of the thermostat daily program that you want to update.
      # @return [Seam::Resources::ActionAttempt] OK
      def update(name:, periods:, thermostat_daily_program_id:, wait_for_action_attempt: nil)
        res = @client.patch("/thermostats/daily_programs/update", {name: name, periods: periods, thermostat_daily_program_id: thermostat_daily_program_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Seam::ActionAttemptResolver.resolve(Seam::Resources::ActionAttempt.load_from_response(Seam::Http::Response.read(res, "action_attempt", "/thermostats/daily_programs/update")), @client, wait_for_action_attempt)
      end
    end
  end
end
