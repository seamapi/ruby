# frozen_string_literal: true

module Seam
  module Clients
    class ConnectWebviews
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Creates a new [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews).
      #
      # To enable a user to connect their devices or systems to Seam, they must sign in to their device or system account. To enable a user to sign in, you create a `connect_webview`. After creating the Connect Webview, you receive a URL that you can use to display the visual component of this Connect Webview for your user. You can open an iframe or new window to display the Connect Webview.
      #
      # You should make a new `connect_webview` for each unique login request. Each `connect_webview` tracks the user that signed in with it. You receive an error if you reuse a Connect Webview for the same user twice or if you use the same Connect Webview for multiple users.
      #
      # See also: [Connect Webview Process](https://docs.seam.co/core-concepts/connect-webviews/connect-webview-process).
      # @param accepted_capabilities [Array<String>, nil] List of accepted device capabilities that restrict the types of devices that can be connected through the Connect Webview. If not provided, defaults will be determined based on the accepted providers.
      # @param accepted_providers [Array<String>, nil] Accepted device provider keys as an alternative to `provider_category`. Use this parameter to specify accepted providers explicitly. See [Customize the Brands to Display in Your Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#customize-the-brands-to-display-in-your-connect-webviews). To list all provider keys, use [`/devices/list_device_providers`](https://docs.seam.co/api/devices/list_device_providers) with no filters.
      # @param automatically_manage_new_devices [Boolean, nil] Indicates whether newly-added devices should appear as [managed devices](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices). See also: [Customize the Behavior Settings of Your Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#customize-the-behavior-settings-of-your-connect-webviews).
      # @param custom_metadata [Hash, nil] Custom metadata that you want to associate with the Connect Webview. Supports up to 50 JSON key:value pairs. [Adding custom metadata to a Connect Webview](https://docs.seam.co/core-concepts/connect-webviews/attaching-custom-data-to-the-connect-webview) enables you to store custom information, like customer details or internal IDs from your application. The custom metadata is then transferred to any [connected accounts](https://docs.seam.co/core-concepts/connected-accounts) that were connected using the Connect Webview, making it easy to find and filter these resources in your [workspace](https://docs.seam.co/core-concepts/workspaces). You can also [filter Connect Webviews by custom metadata](https://docs.seam.co/core-concepts/connect-webviews/filtering-connect-webviews-by-custom-metadata).
      # @param custom_redirect_failure_url [String, nil] Alternative URL that you want to redirect the user to on an error. If you do not set this parameter, the Connect Webview falls back to the `custom_redirect_url`.
      # @param custom_redirect_url [String, nil] URL that you want to redirect the user to after the provider login is complete.
      # @param customer_key [String, nil] Associate the Connect Webview, the connected account, and all resources under the connected account with a customer. If the connected account already exists, it will be associated with the customer. If the connected account already exists, but is already associated with a customer, the Connect Webview will show an error.
      # @param excluded_providers [Array<String>, nil] List of provider keys to exclude from the Connect Webview. These providers will not be shown when the user tries to connect an account.
      # @param provider_category [String, nil] Specifies the category of providers that you want to include. To list all providers within a category, use [`/devices/list_device_providers`](https://docs.seam.co/api/devices/list_device_providers) with the desired `provider_category` filter.
      # @param wait_for_device_creation [Boolean, nil] Indicates whether Seam should finish syncing all devices in a newly-connected account before completing the associated Connect Webview. See also: [Customize the Behavior Settings of Your Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#customize-the-behavior-settings-of-your-connect-webviews).
      # @return [Seam::Resources::ConnectWebview] OK
      def create(accepted_capabilities: nil, accepted_providers: nil, automatically_manage_new_devices: nil, custom_metadata: nil, custom_redirect_failure_url: nil, custom_redirect_url: nil, customer_key: nil, excluded_providers: nil, provider_category: nil, wait_for_device_creation: nil)
        res = @client.post("/connect_webviews/create", {accepted_capabilities: accepted_capabilities, accepted_providers: accepted_providers, automatically_manage_new_devices: automatically_manage_new_devices, custom_metadata: custom_metadata, custom_redirect_failure_url: custom_redirect_failure_url, custom_redirect_url: custom_redirect_url, customer_key: customer_key, excluded_providers: excluded_providers, provider_category: provider_category, wait_for_device_creation: wait_for_device_creation}.compact)

        Seam::Resources::ConnectWebview.load_from_response(res.body["connect_webview"])
      end

      # Deletes a [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews).
      #
      # You do not need to delete a Connect Webview once a user completes it. Instead, you can simply ignore completed Connect Webviews.
      # @param connect_webview_id [String] ID of the Connect Webview that you want to delete.
      # @return [nil] OK
      def delete(connect_webview_id:)
        @client.post("/connect_webviews/delete", {connect_webview_id: connect_webview_id}.compact)

        nil
      end

      # Returns a specified [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews).
      #
      # Unless you're using a `custom_redirect_url`, you should poll a newly-created `connect_webview` to find out if the user has signed in or to get details about what devices they've connected.
      # @param connect_webview_id [String] ID of the Connect Webview that you want to get.
      # @return [Seam::Resources::ConnectWebview] OK
      def get(connect_webview_id:)
        res = @client.post("/connect_webviews/get", {connect_webview_id: connect_webview_id}.compact)

        Seam::Resources::ConnectWebview.load_from_response(res.body["connect_webview"])
      end

      # Returns a list of all [Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews).
      # @param custom_metadata_has [Hash, nil] Custom metadata pairs by which you want to [filter Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews/filtering-connect-webviews-by-custom-metadata). Returns Connect Webviews with `custom_metadata` that contains all of the provided key:value pairs.
      # @param customer_key [String, nil] Customer key for which you want to list connect webviews.
      # @param limit [Float, nil] Maximum number of records to return per page.
      # @param page_cursor [String, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search [String, nil] String for which to search. Filters returned Connect Webviews to include all records that satisfy a partial match using `connect_webview_id`, `accepted_providers`, `custom_metadata`, or `customer_key`.
      # @param user_identifier_key [String, nil] Your user ID for the user by which you want to filter Connect Webviews.
      # @return [Seam::Resources::ConnectWebview] OK
      def list(custom_metadata_has: nil, customer_key: nil, limit: nil, page_cursor: nil, search: nil, user_identifier_key: nil)
        res = @client.post("/connect_webviews/list", {custom_metadata_has: custom_metadata_has, customer_key: customer_key, limit: limit, page_cursor: page_cursor, search: search, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::ConnectWebview.load_from_response(res.body["connect_webviews"])
      end
    end
  end
end
