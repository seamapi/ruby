# frozen_string_literal: true

module Seam
  class ClientSession < BaseResource
    attr_accessor :client_session_id, :connect_webview_ids, :connected_account_ids, :device_count, :token, :user_identifier_key, :user_identity_ids, :workspace_id

    date_accessor :created_at
  end
end
