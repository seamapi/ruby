# frozen_string_literal: true

module Seam
  module Resources
    class AcsAccessGroup < BaseResource
      attr_accessor :access_group_type, :access_group_type_display_name, :acs_access_group_id, :acs_system_id, :connected_account_id, :display_name, :external_type, :external_type_display_name, :is_managed, :name, :workspace_id

      date_accessor :created_at

      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
