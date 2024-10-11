# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class AcsEncoders < BaseClient
      def encode_card(acs_system_id: nil, device_name: nil, device_id: nil, wait_for_action_attempt: nil)
        action_attempt = request_seam_object(
          :post,
          "/acs/encoders/encode_card",
          Seam::Resources::ActionAttempt,
          "action_attempt",
          body: {acs_system_id: acs_system_id, device_name: device_name, device_id: device_id}.compact
        )

        Helpers::ActionAttempt.decide_and_wait(action_attempt, @client, wait_for_action_attempt)
      end

      def list(acs_system_ids: nil, device_ids: nil, limit: nil)
        request_seam_object(
          :post,
          "/acs/encoders/list",
          Seam::Resources::Device,
          "devices",
          body: {acs_system_ids: acs_system_ids, device_ids: device_ids, limit: limit}.compact
        )
      end

      def scan_card(acs_system_id:, device_name: nil, device_id: nil, wait_for_action_attempt: nil)
        action_attempt = request_seam_object(
          :post,
          "/acs/encoders/scan_card",
          Seam::Resources::ActionAttempt,
          "action_attempt",
          body: {acs_system_id: acs_system_id, device_name: device_name, device_id: device_id}.compact
        )

        Helpers::ActionAttempt.decide_and_wait(action_attempt, @client, wait_for_action_attempt)
      end
    end
  end
end
