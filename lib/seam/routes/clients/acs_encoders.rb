# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class AcsEncoders
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def encode_card(acs_credential_id:, device_id:, wait_for_action_attempt: nil)
        res = @client.post("/acs/encoders/encode_card", {acs_credential_id: acs_credential_id, device_id: device_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      def list(acs_system_ids: nil, device_ids: nil, limit: nil)
        res = @client.post("/acs/encoders/list", {acs_system_ids: acs_system_ids, device_ids: device_ids, limit: limit}.compact)

        Seam::Resources::Device.load_from_response(res.body["devices"])
      end

      def scan_card(acs_system_id:, device_id:, wait_for_action_attempt: nil)
        res = @client.post("/acs/encoders/scan_card", {acs_system_id: acs_system_id, device_id: device_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end
    end
  end
end
