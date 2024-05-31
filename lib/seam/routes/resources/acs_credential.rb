# frozen_string_literal: true

module Seam
  class AcsCredential < BaseResource
    attr_accessor :access_method, :acs_credential_id, :acs_credential_pool_id, :acs_system_id, :acs_user_id, :code, :display_name, :ends_at, :external_type, :external_type_display_name, :is_multi_phone_sync_credential, :parent_acs_credential_id, :starts_at, :visionline_metadata, :workspace_id

    date_accessor :created_at

    include Seam::ResourceErrorsSupport
    include Seam::ResourceWarningsSupport
  end
end
