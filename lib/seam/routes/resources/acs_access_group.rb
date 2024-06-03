# frozen_string_literal: true

module Seam
  class AcsAccessGroup < BaseResource
    attr_accessor :access_group_type, :access_group_type_display_name, :acs_access_group_id, :acs_system_id, :external_type, :external_type_display_name, :name, :workspace_id

    date_accessor :created_at
  end
end
