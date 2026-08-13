# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class LocksSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Simulates the entry of a code on a keypad. You can only perform this action for [August](https://docs.seam.co/device-and-system-integration-guides/august-locks) devices within [sandbox workspaces](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces).
      # @param code [String] Code that you want to simulate entering on a keypad.
      # @param device_id [String] ID of the device for which you want to simulate a keypad code entry.
      # @return [Seam::Resources::ActionAttempt] OK
      def keypad_code_entry(code:, device_id:, wait_for_action_attempt: nil)
        res = @client.post("/locks/simulate/keypad_code_entry", {code: code, device_id: device_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Simulates a manual lock action using a keypad. You can only perform this action for [August](https://docs.seam.co/device-and-system-integration-guides/august-locks) devices within [sandbox workspaces](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces).
      # @param device_id [String] ID of the device for which you want to simulate a manual lock action using a keypad.
      # @return [Seam::Resources::ActionAttempt] OK
      def manual_lock_via_keypad(device_id:, wait_for_action_attempt: nil)
        res = @client.post("/locks/simulate/manual_lock_via_keypad", {device_id: device_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end
    end
  end
end
