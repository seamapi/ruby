# frozen_string_literal: true

module Seam
  module Resources
    class AcsCredential < BaseResource
      attr_accessor :access_method, :acs_credential_id, :acs_credential_pool_id, :acs_system_id, :acs_user_id, :assa_abloy_vostio_metadata, :card_number, :code, :display_name, :ends_at, :external_type, :external_type_display_name, :is_issued, :is_latest_desired_state_synced_with_provider, :is_managed, :is_multi_phone_sync_credential, :is_one_time_use, :parent_acs_credential_id, :starts_at, :visionline_metadata, :workspace_id

      date_accessor :created_at, :issued_at, :latest_desired_state_synced_with_provider_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
