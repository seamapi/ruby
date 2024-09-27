# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class AcsEncoders < BaseClient
      def read_card(acs_system_id: nil, device_name: nil, device_id: nil, wait_for_action_attempt: nil)
        action_attempt = request_seam_object(
          :post,
          "/acs/encoders/read_card",
          Seam::ActionAttempt,
          "action_attempt",
          body: {acs_system_id: acs_system_id, device_name: device_name, device_id: device_id}.compact
        )

        Helpers::ActionAttempt.decide_and_wait(action_attempt, @client, wait_for_action_attempt)
      end
    end
  end
end
