# frozen_string_literal: true

module Seam
  module Clients
    class Workspaces < BaseClient
      def create(name:, company_name: nil, connect_partner_name: nil, is_sandbox: nil, webview_logo_shape: nil, webview_primary_button_color: nil)
        request_seam_object(
          :post,
          "/workspaces/create",
          Seam::Workspace,
          "workspace",
          body: {name: name, company_name: company_name, connect_partner_name: connect_partner_name, is_sandbox: is_sandbox, webview_logo_shape: webview_logo_shape, webview_primary_button_color: webview_primary_button_color}.compact
        )
      end

      def get
        request_seam_object(
          :post,
          "/workspaces/get",
          Seam::Workspace,
          "workspace",
          body: {}.compact
        )
      end

      def list
        request_seam_object(
          :post,
          "/workspaces/list",
          Seam::Workspace,
          "workspaces",
          body: {}.compact
        )
      end

      def reset_sandbox(wait_for_action_attempt: nil)
        action_attempt = request_seam_object(
          :post,
          "/workspaces/reset_sandbox",
          Seam::ActionAttempt,
          "action_attempt",
          body: {}.compact
        )

        action_attempt.decide_and_wait(wait_for_action_attempt)
        action_attempt
      end
    end
  end
end
