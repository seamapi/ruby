# frozen_string_literal: true

module Seam
  module Resources
    class ActionAttempt < BaseResource
      attr_accessor :action_attempt_id, :action_type, :error, :result, :status
    end
  end
end
