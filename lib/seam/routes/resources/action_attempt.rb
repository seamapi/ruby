# frozen_string_literal: true

require "seam/utils/action_attempt_utils"

module Seam
  class ActionAttempt < BaseResource
    attr_accessor :action_attempt_id, :action_type, :error, :result, :status

    def decide_and_wait(wait_for_action_attempt)
      Seam::Utils::ActionAttemptUtils.decide_and_wait(self, @client, wait_for_action_attempt)
    end
  end
end
