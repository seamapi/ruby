# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class LocksSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def keypad_code_entry(code:, device_id:, wait_for_action_attempt: nil)
        res = @client.post("/locks/simulate/keypad_code_entry", {code: code, device_id: device_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      def manual_lock_via_keypad(device_id:, wait_for_action_attempt: nil)
        res = @client.post("/locks/simulate/manual_lock_via_keypad", {device_id: device_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end
    end
  end
end
