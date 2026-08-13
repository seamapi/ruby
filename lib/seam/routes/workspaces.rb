# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class Workspaces
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Creates a new [workspace](https://docs.seam.co/core-concepts/workspaces).
      # @param name [String] Name of the new workspace.
      # @param company_name [String, nil] Company name for the new workspace.
      # @param connect_partner_name [String, nil] Connect partner name for the new workspace.
      # @deprecated connect_partner_name: Use `company_name` instead.
      # @param connect_webview_customization [Hash, nil] [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews) customizations for the new workspace. See also [Customize the Look and Feel of Your Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#customize-the-look-and-feel-of-your-connect-webviews).
      # @param is_sandbox [Boolean, nil] Indicates whether the new workspace is a [sandbox workspace](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces).
      # @param organization_id [String, nil] ID of the organization to associate with the new workspace.
      # @param webview_logo_shape [String, nil]
      # @deprecated webview_logo_shape: Use `connect_webview_customization.webview_logo_shape` instead.
      # @param webview_primary_button_color [String, nil]
      # @deprecated webview_primary_button_color: Use `connect_webview_customization.webview_primary_button_color` instead.
      # @param webview_primary_button_text_color [String, nil]
      # @deprecated webview_primary_button_text_color: Use `connect_webview_customization.webview_primary_button_text_color` instead.
      # @param webview_success_message [String, nil]
      # @deprecated webview_success_message: Use `connect_webview_customization.webview_success_message` instead.
      # @return [Seam::Resources::Workspace] OK
      def create(name:, company_name: nil, connect_partner_name: nil, connect_webview_customization: nil, is_sandbox: nil, organization_id: nil, webview_logo_shape: nil, webview_primary_button_color: nil, webview_primary_button_text_color: nil, webview_success_message: nil)
        res = @client.post("/workspaces/create", {name: name, company_name: company_name, connect_partner_name: connect_partner_name, connect_webview_customization: connect_webview_customization, is_sandbox: is_sandbox, organization_id: organization_id, webview_logo_shape: webview_logo_shape, webview_primary_button_color: webview_primary_button_color, webview_primary_button_text_color: webview_primary_button_text_color, webview_success_message: webview_success_message}.compact)

        Seam::Resources::Workspace.load_from_response(res.body["workspace"])
      end

      # Returns the [workspace](https://docs.seam.co/core-concepts/workspaces) associated with the authentication value.
      # @return [Seam::Resources::Workspace] OK
      def get
        res = @client.get("/workspaces/get")

        Seam::Resources::Workspace.load_from_response(res.body["workspace"])
      end

      # Returns a list of [workspaces](https://docs.seam.co/core-concepts/workspaces) associated with the authentication value.
      # @return [Seam::Resources::Workspace] OK
      def list
        res = @client.get("/workspaces/list")

        Seam::Resources::Workspace.load_from_response(res.body["workspaces"])
      end

      # Resets the [sandbox workspace](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces) associated with the authentication value. Note that this endpoint is only available for sandbox workspaces.
      # @return [Seam::Resources::ActionAttempt] OK
      def reset_sandbox(wait_for_action_attempt: nil)
        res = @client.post("/workspaces/reset_sandbox")

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Updates the [workspace](https://docs.seam.co/core-concepts/workspaces) associated with the authentication value.
      # @param connect_partner_name [String, nil] Connect partner name for the workspace.
      # @param connect_webview_customization [Hash, nil] [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews) customizations for the workspace. See also [Customize the Look and Feel of Your Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#customize-the-look-and-feel-of-your-connect-webviews).
      # @param is_publishable_key_auth_enabled [Boolean, nil] Indicates whether publishable key authentication is enabled for this workspace.
      # @param is_suspended [Boolean, nil] Indicates whether the workspace is suspended.
      # @param name [String, nil] Name of the workspace.
      # @param organization_id [String, nil] ID of the organization to assign the workspace to. The authenticated user must be the owner of the workspace and an admin of the target organization.
      # @return [nil] OK
      def update(connect_partner_name: nil, connect_webview_customization: nil, is_publishable_key_auth_enabled: nil, is_suspended: nil, name: nil, organization_id: nil)
        @client.patch("/workspaces/update", {connect_partner_name: connect_partner_name, connect_webview_customization: connect_webview_customization, is_publishable_key_auth_enabled: is_publishable_key_auth_enabled, is_suspended: is_suspended, name: name, organization_id: organization_id}.compact)

        nil
      end
    end
  end
end
