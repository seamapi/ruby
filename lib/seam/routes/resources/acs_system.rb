# frozen_string_literal: true

module Seam
  class AcsSystem < BaseResource
    attr_accessor :acs_system_id, :can_add_acs_users_to_acs_access_groups, :can_automate_enrollment, :can_create_acs_access_groups, :can_remove_acs_users_from_acs_access_groups, :connected_account_ids, :external_type, :external_type_display_name, :image_alt_text, :image_url, :name, :system_type, :system_type_display_name, :visionline_metadata, :workspace_id

    date_accessor :created_at

    include Seam::ResourceErrorsSupport
    include Seam::ResourceWarningsSupport
  end
end
