# frozen_string_literal: true

require_relative "seam/logger"
require_relative "seam/http"
require_relative "seam/wait_for_action_attempt"
require_relative "seam/webhook"

module Seam
  def self.new(**args)
    Http.new(**args)
  end

  def self.from_api_key(api_key, endpoint: nil, wait_for_action_attempt: false, debug: false)
    Http.from_api_key(api_key, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt, debug: debug)
  end

  def self.from_personal_access_token(personal_access_token, workspace_id, endpoint: nil, wait_for_action_attempt: false, debug: false)
    Http.from_personal_access_token(personal_access_token, workspace_id, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt, debug: debug)
  end

  def self.lts_version
    Seam::LTS_VERSION
  end
end
