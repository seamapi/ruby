# frozen_string_literal: true

module Seam
  module Resources
    class ConnectWebview < BaseResource
      attr_accessor :accepted_capabilities, :accepted_devices, :accepted_providers, :any_device_allowed, :any_provider_allowed, :automatically_manage_new_devices, :connect_webview_id, :connected_account_id, :custom_metadata, :custom_redirect_failure_url, :custom_redirect_url, :device_selection_mode, :login_successful, :selected_provider, :status, :url, :wait_for_device_creation, :workspace_id

      date_accessor :authorized_at, :created_at
    end
  end
end
