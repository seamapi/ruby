# frozen_string_literal: true

require_relative "seam/version"
require_relative "seam/lts_version"
require_relative "seam/default_endpoint"
require_relative "seam/request"
require_relative "seam/logger"
require_relative "seam/http"
require_relative "seam/http_multi_workspace"
require_relative "seam/base_client"
require_relative "seam/base_resource"
require_relative "seam/errors"

require_relative "seam/routes/resources/index"
require_relative "seam/routes/clients/index"

module Seam
  def self.new(**args)
    Http.new(**args)
  end

  def self.from_api_key(api_key, endpoint: nil, wait_for_action_attempt: false, debug: false)
    new(api_key: api_key, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt, debug: debug)
  end

  def self.from_personal_access_token(personal_access_token, workspace_id, endpoint: nil, wait_for_action_attempt: false, debug: false)
    new(personal_access_token: personal_access_token, workspace_id: workspace_id, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt, debug: debug)
  end

  def self.lts_version
    Seam::LTS_VERSION
  end
end
