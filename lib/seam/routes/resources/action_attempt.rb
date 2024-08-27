# frozen_string_literal: true

module Seam
  class ActionAttempt < BaseResource
    attr_accessor :action_attempt_id, :action_type, :error, :result, :status
  end
end
