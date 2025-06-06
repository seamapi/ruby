# frozen_string_literal: true

module Seam
  module Resources
    class AcsSystem < BaseResource
      attr_accessor :acs_access_group_count, :acs_system_id, :acs_user_count, :connected_account_id, :connected_account_ids, :default_credential_manager_acs_system_id, :external_type, :external_type_display_name, :image_alt_text, :image_url, :is_credential_manager, :location, :name, :system_type, :system_type_display_name, :visionline_metadata, :workspace_id

      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
