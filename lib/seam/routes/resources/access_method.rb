# frozen_string_literal: true

module Seam
  module Resources
    class AccessMethod < BaseResource
      attr_accessor :access_method_id, :client_session_token, :code, :display_name, :instant_key_url, :is_encoding_required, :mode, :workspace_id

      date_accessor :created_at, :issued_at
    end
  end
end
