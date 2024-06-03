# frozen_string_literal: true

module Seam
  class Workspace < BaseResource
    attr_accessor :connect_partner_name, :is_sandbox, :name, :workspace_id
  end
end
