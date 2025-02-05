# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class AcsEncoders
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def encode_credential(acs_credential_id:, acs_encoder_id:, wait_for_action_attempt: nil)
        res = @client.post("/acs/encoders/encode_credential", {acs_credential_id: acs_credential_id, acs_encoder_id: acs_encoder_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      def list(acs_system_id: nil, limit: nil, acs_system_ids: nil, acs_encoder_ids: nil)
        res = @client.post("/acs/encoders/list", {acs_system_id: acs_system_id, limit: limit, acs_system_ids: acs_system_ids, acs_encoder_ids: acs_encoder_ids}.compact)

        Seam::Resources::AcsEncoder.load_from_response(res.body["acs_encoders"])
      end

      def scan_credential(acs_encoder_id:, wait_for_action_attempt: nil)
        res = @client.post("/acs/encoders/scan_credential", {acs_encoder_id: acs_encoder_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end
    end
  end
end
