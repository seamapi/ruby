# frozen_string_literal: true

module Seam
  module Resources
    # Represents a Seam [workspace](https://docs.seam.co/core-concepts/workspaces). A workspace is a top-level entity that encompasses all other resources below it, such as devices, connected accounts, and Connect Webviews. Seam provides two types of workspaces. A [sandbox workspace](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces) is a special type of workspace designed for testing code. Sandbox workspaces offer test device accounts and virtual devices that you can connect and control. This ability to work with virtual devices is quite handy because it removes the need to own physical devices from multiple brands. To connect real devices and systems to Seam, use a [production workspace](https://docs.seam.co/core-concepts/workspaces#production-workspaces).
    class Workspace < BaseResource
      class ConnectWebviewCustomization < BaseResource
        # URL of the inviter logo for [Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews) in the workspace. See also [Customize the Look and Feel of Your Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#customize-the-look-and-feel-of-your-connect-webviews).
        # @return [String, nil]
        attr_accessor :inviter_logo_url
        # Logo shape for [Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews) in the workspace. See also [Customize the Look and Feel of Your Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#customize-the-look-and-feel-of-your-connect-webviews).
        # @return [String, nil]
        attr_accessor :logo_shape
        # Primary button color for [Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews) in the workspace. See also [Customize the Look and Feel of Your Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#customize-the-look-and-feel-of-your-connect-webviews).
        # @return [String, nil]
        attr_accessor :primary_button_color
        # Primary button text color for [Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews) in the workspace. See also [Customize the Look and Feel of Your Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#customize-the-look-and-feel-of-your-connect-webviews).
        # @return [String, nil]
        attr_accessor :primary_button_text_color
        # Success message for [Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews) in the workspace. See also [Customize the Look and Feel of Your Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#customize-the-look-and-feel-of-your-connect-webviews).
        # @return [String, nil]
        attr_accessor :success_message
      end

      # @return [ConnectWebviewCustomization]
      resource_accessor :connect_webview_customization, ConnectWebviewCustomization
      # Company name associated with the [workspace](https://docs.seam.co/core-concepts/workspaces).
      # @return [String]
      attr_accessor :company_name
      # @return [String, nil]
      # @deprecated Use `company_name` instead.
      attr_accessor :connect_partner_name
      # Indicates whether publishable key authentication is enabled for this workspace.
      # @return [Boolean]
      attr_accessor :is_publishable_key_auth_enabled
      # Indicates whether the workspace is a [sandbox workspace](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces).
      # @return [Boolean]
      attr_accessor :is_sandbox
      # Indicates whether the [sandbox workspace](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces) is suspended. Seam suspends sandbox workspaces that have not been accessed in 14 days.
      # @return [Boolean]
      attr_accessor :is_suspended
      # Name of the [workspace](https://docs.seam.co/core-concepts/workspaces).
      # @return [String]
      attr_accessor :name
      # ID of the organization to which the workspace belongs, or `null` if the workspace is not assigned to an organization.
      # @return [String, nil]
      attr_accessor :organization_id
      # Publishable key for the [workspace](https://docs.seam.co/core-concepts/workspaces). This key is used to identify the workspace in client-side applications.
      # @return [String, nil]
      attr_accessor :publishable_key
      # ID of the workspace.
      # @return [String]
      attr_accessor :workspace_id
    end
  end
end
