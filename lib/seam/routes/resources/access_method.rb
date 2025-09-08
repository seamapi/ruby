# frozen_string_literal: true

module Seam
  module Resources
    class AccessMethod < BaseResource
      attr_accessor :access_method_id, :client_session_token, :code, :customization_profile_id, :display_name, :instant_key_url, :is_encoding_required, :is_issued, :mode, :workspace_id

      date_accessor :created_at, :issued_at

      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
