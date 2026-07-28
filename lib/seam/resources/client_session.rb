# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens). If you want to restrict your users' access to their own devices, use client sessions.
    #
    # You create each client session with a custom `user_identifier_key`. Normally, the `user_identifier_key` is a user ID that your application provides.
    #
    # When calling the Seam API from your backend using an API key, you can pass the `user_identifier_key` as a parameter to limit results to the associated client session. For example, `/devices/list?user_identifier_key=123` only returns devices associated with the client session created with the `user_identifier_key` `123`.
    #
    # A client session has a token that you can use with the Seam JavaScript SDK to make requests from the client (browser) directly to the Seam API. The token restricts the user's access to only the devices that they own.
    #
    # See also [Get Started with React](https://docs.seam.co/ui-components/overview/getting-started-with-seam-components/get-started-with-react-components-and-client-session-tokens).
    class ClientSession < BaseResource
      # ID of the client session.
      attr_accessor :client_session_id
      # IDs of the [Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews) associated with the [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens).
      attr_accessor :connect_webview_ids
      # IDs of the [connected accounts](https://docs.seam.co/core-concepts/connected-accounts) associated with the [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens).
      attr_accessor :connected_account_ids
      # Customer key associated with the [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens).
      attr_accessor :customer_key
      # Number of devices associated with the [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens).
      attr_accessor :device_count
      # Client session token associated with the [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens).
      attr_accessor :token
      # Your user ID for the user associated with the [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens).
      attr_accessor :user_identifier_key
      # ID of the [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) associated with the client session.
      attr_accessor :user_identity_id
      # IDs of the [user identities](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) associated with the client session.
      # @deprecated Use `user_identity_id` instead.
      attr_accessor :user_identity_ids
      # ID of the workspace associated with the client session.
      attr_accessor :workspace_id

      # Date and time at which the [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens) was created.
      date_accessor :created_at

      # Date and time at which the [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens) expires.
      date_accessor :expires_at
    end
  end
end
