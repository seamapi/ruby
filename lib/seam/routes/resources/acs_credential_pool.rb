# frozen_string_literal: true

module Seam
  module Resources
    class AcsCredentialPool < BaseResource
      attr_accessor :acs_credential_pool_id, :acs_system_id, :display_name, :external_type, :external_type_display_name, :workspace_id

      date_accessor :created_at
    end
  end
end
