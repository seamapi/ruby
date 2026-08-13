# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews).
    #
    # Connect Webviews are fully-embedded client-side components that you add to your app. Your users interact with your embedded Connect Webviews to link their IoT device or system accounts to Seam. That is, Connect Webviews walk your users through the process of logging in to their device or system accounts. Seam handles all the authentication steps, and—once your user has completed the authorization through your app—you can access and control their devices or systems using the Seam API.
    #
    # Connect Webviews perform credential validation, multifactor authentication (when applicable), and error handling for each brand that Seam supports. Further, Connect Webviews work across all modern browsers and platforms, including Chrome, Safari, and Firefox.
    #
    # To enable a user to connect their device or system account to Seam through your app, first create a `connect_webview`. Once created, this `connect_webview` includes a URL that you can use to open an [iframe](https://www.w3schools.com/html/html_iframe.asp) or new window containing the Connect Webview for your user.
    #
    # When you create a Connect Webview, specify the desired provider category key in the `provider_category` parameter. Alternately, to specify a list of providers explicitly, use the `accepted_providers` parameter with a list of device provider keys.
    #
    # To list all providers within a category, use `/devices/list_device_providers` with the desired `provider_category` filter. To list all provider keys, use `/devices/list_device_providers` with no filters.
    class ConnectWebview < BaseResource
      # High-level device capabilities that the Connect Webview can accept. When creating a Connect Webview, you can specify the types of devices that it can connect to Seam. If you do not set custom `accepted_capabilities`, Seam uses a default set of `accepted_capabilities` for each provider. For example, if you create a Connect Webview that accepts SmartThing devices, without specifying `accepted_capabilities`, Seam accepts only SmartThings locks. To connect SmartThings thermostats and locks to Seam, create a Connect Webview and include both `thermostat` and `lock` in the `accepted_capabilities`.
      # @return [Array<String>]
      attr_accessor :accepted_capabilities
      # List of accepted [provider keys](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#customize-the-brands-to-display-in-your-connect-webviews).
      # @return [Array<String>]
      attr_accessor :accepted_providers
      # Indicates whether any provider is allowed.
      # @return [Boolean]
      attr_accessor :any_provider_allowed
      # Indicates whether Seam should [import all new devices](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#automatically_manage_new_devices) for the connected account to make these devices available for use and management by the Seam API.
      # @return [Boolean]
      attr_accessor :automatically_manage_new_devices
      # ID of the Connect Webview.
      # @return [String]
      attr_accessor :connect_webview_id
      # ID of the connected account associated with the Connect Webview.
      # @return [String, nil]
      attr_accessor :connected_account_id
      # Set of key:value pairs. Adding custom metadata to a resource, such as a [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews/attaching-custom-data-to-the-connect-webview), [connected account](https://docs.seam.co/core-concepts/connected-accounts/adding-custom-metadata-to-a-connected-account), or [device](https://docs.seam.co/core-concepts/devices/adding-custom-metadata-to-a-device), enables you to store custom information, like customer details or internal IDs from your application.
      # @return [Hash]
      attr_accessor :custom_metadata
      # URL to which the Connect Webview should redirect when an unexpected error occurs.
      # @return [String, nil]
      attr_accessor :custom_redirect_failure_url
      # URL to which the Connect Webview should redirect when the user successfully pairs a device or system. If you do not set the `custom_redirect_failure_url`, the Connect Webview redirects to the `custom_redirect_url` when an unexpected error occurs.
      # @return [String, nil]
      attr_accessor :custom_redirect_url
      # The customer key associated with this webview, if any.
      # @return [String, nil]
      attr_accessor :customer_key
      # Device selection mode of the Connect Webview. Supported values: `none`, `single`, `multiple`.
      # @return [String]
      attr_accessor :device_selection_mode
      # Indicates whether the user logged in successfully using the Connect Webview.
      # @return [Boolean]
      attr_accessor :login_successful
      # Selected provider of the Connect Webview, one of the [provider keys](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#customize-the-brands-to-display-in-your-connect-webviews).
      # @return [String, nil]
      attr_accessor :selected_provider
      # Status of the Connect Webview. `authorized` indicates that the user has successfully logged into their device or system account, thereby completing the Connect Webview.
      # @return [String]
      attr_accessor :status
      # URL for the Connect Webview. You use the URL to display the Connect Webview flow to your user.
      # @return [String]
      attr_accessor :url
      # Indicates whether Seam should [finish syncing all devices](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#wait_for_device_creation) in a newly-connected account before completing the associated Connect Webview.
      # @return [Boolean]
      attr_accessor :wait_for_device_creation
      # ID of the workspace that contains the Connect Webview.
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the user authorized (through the Connect Webview) the management of their devices.
      # @return [Time, nil]
      date_accessor :authorized_at

      # Date and time at which the Connect Webview was created.
      # @return [Time]
      date_accessor :created_at
    end
  end
end
