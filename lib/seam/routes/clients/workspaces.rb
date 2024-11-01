# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class Workspaces
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create(name:, company_name: nil, connect_partner_name: nil, is_sandbox: nil, webview_logo_shape: nil, webview_primary_button_color: nil, webview_primary_button_text_color: nil)
        res = @client.post("/workspaces/create", {name: name, company_name: company_name, connect_partner_name: connect_partner_name, is_sandbox: is_sandbox, webview_logo_shape: webview_logo_shape, webview_primary_button_color: webview_primary_button_color, webview_primary_button_text_color: webview_primary_button_text_color}.compact)

        Seam::Resources::Workspace.load_from_response(res.body["workspace"])
      end

      def get
        res = @client.post("/workspaces/get")

        Seam::Resources::Workspace.load_from_response(res.body["workspace"])
      end

      def list
        res = @client.post("/workspaces/list")

        Seam::Resources::Workspace.load_from_response(res.body["workspaces"])
      end

      def reset_sandbox(wait_for_action_attempt: nil)
        res = @client.post("/workspaces/reset_sandbox")

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end
    end
  end
end
