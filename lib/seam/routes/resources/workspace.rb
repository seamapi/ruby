# frozen_string_literal: true

module Seam
  class Workspace < BaseResource
    attr_accessor :company_name, :connect_partner_name, :is_sandbox, :name, :workspace_id
  end
end
