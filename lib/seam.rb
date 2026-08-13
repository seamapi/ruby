# frozen_string_literal: true

require_relative "seam/http"
require_relative "seam/http_without_workspace"
require_relative "seam/webhook"
require_relative "seam/wait_for_action_attempt"

module Seam
  def self.new(**args)
    Seam::Http.new(**args)
  end

  def self.from_api_key(api_key, endpoint: nil, wait_for_action_attempt: true, timeout: nil)
    Seam::Http.from_api_key(api_key, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt,
      timeout: timeout)
  end

  def self.from_personal_access_token(personal_access_token, workspace_id, endpoint: nil, wait_for_action_attempt: true, timeout: nil)
    Seam::Http.from_personal_access_token(personal_access_token, workspace_id, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt, timeout: timeout)
  end
end
