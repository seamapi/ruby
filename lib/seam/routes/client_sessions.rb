# frozen_string_literal: true

require "seam/response"

module Seam
  module Clients
    class ClientSessions
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Creates a new [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens).
      # @param connect_webview_ids [Array<String>, nil] IDs of the [Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews) for which you want to create a client session.
      # @param connected_account_ids [Array<String>, nil] IDs of the [connected accounts](https://docs.seam.co/core-concepts/connected-accounts) for which you want to create a client session.
      # @param customer_id [String, nil] Customer ID that you want to associate with the new client session.
      # @param customer_key [String, nil] Customer key that you want to associate with the new client session.
      # @param expires_at [Time, nil] Date and time at which the client session should expire, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @param user_identifier_key [String, nil] Your user ID for the user for whom you want to create a client session.
      # @param user_identity_id [String, nil] ID of the [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) for which you want to create a client session.
      # @param user_identity_ids [Array<String>, nil] IDs of the [user identities](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) that you want to associate with the client session.
      # @deprecated user_identity_ids: Use `user_identity_id` instead.
      # @return [Seam::Resources::ClientSession] OK
      def create(connect_webview_ids: nil, connected_account_ids: nil, customer_id: nil, customer_key: nil, expires_at: nil, user_identifier_key: nil, user_identity_id: nil, user_identity_ids: nil)
        res = @client.put("/client_sessions/create", {connect_webview_ids: connect_webview_ids, connected_account_ids: connected_account_ids, customer_id: customer_id, customer_key: customer_key, expires_at: expires_at, user_identifier_key: user_identifier_key, user_identity_id: user_identity_id, user_identity_ids: user_identity_ids}.compact)

        Seam::Resources::ClientSession.load_from_response(Seam::Http::Response.read(res, "client_session", "/client_sessions/create"))
      end

      # Deletes a [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens).
      # @param client_session_id [String] ID of the client session that you want to delete.
      # @return [nil] OK
      def delete(client_session_id:)
        @client.delete("/client_sessions/delete", {client_session_id: client_session_id}.compact)

        nil
      end

      # Returns a specified [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens).
      # @param client_session_id [String, nil] ID of the client session that you want to get.
      # @param user_identifier_key [String, nil] User identifier key associated with the client session that you want to get.
      # @return [Seam::Resources::ClientSession] OK
      def get(client_session_id: nil, user_identifier_key: nil)
        res = @client.get("/client_sessions/get", {client_session_id: client_session_id, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::ClientSession.load_from_response(Seam::Http::Response.read(res, "client_session", "/client_sessions/get"))
      end

      # Returns a [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens) with specific characteristics or creates a new client session with these characteristics if it does not yet exist.
      # @param connect_webview_ids [Array<String>, nil] IDs of the [Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews) that you want to associate with the client session (or that are already associated with the existing client session).
      # @param connected_account_ids [Array<String>, nil] IDs of the [connected accounts](https://docs.seam.co/api/connected_accounts) that you want to associate with the client session (or that are already associated with the existing client session).
      # @param expires_at [Time, nil] Date and time at which the client session should expire in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. If the client session already exists, this will update the expiration before returning it.
      # @param user_identifier_key [String, nil] Your user ID for the user that you want to associate with the client session (or that is already associated with the existing client session).
      # @param user_identity_id [String, nil] ID of the [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) that you want to associate with the client session (or that are already associated with the existing client session).
      # @param user_identity_ids [Array<String>, nil] IDs of the [user identities](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) that you want to associate with the client session.
      # @deprecated user_identity_ids: Use `user_identity_id`.
      # @return [Seam::Resources::ClientSession] OK
      def get_or_create(connect_webview_ids: nil, connected_account_ids: nil, expires_at: nil, user_identifier_key: nil, user_identity_id: nil, user_identity_ids: nil)
        res = @client.post("/client_sessions/get_or_create", {connect_webview_ids: connect_webview_ids, connected_account_ids: connected_account_ids, expires_at: expires_at, user_identifier_key: user_identifier_key, user_identity_id: user_identity_id, user_identity_ids: user_identity_ids}.compact)

        Seam::Resources::ClientSession.load_from_response(Seam::Http::Response.read(res, "client_session", "/client_sessions/get_or_create"))
      end

      # Grants a [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens) access to one or more resources, such as [Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews), [user identities](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity), and so on.
      # @param client_session_id [String, nil] ID of the client session to which you want to grant access to resources.
      # @param connect_webview_ids [Array<String>, nil] IDs of the [Connect Webviews](https://docs.seam.co/core-concepts/connect-webviews) that you want to associate with the client session.
      # @param connected_account_ids [Array<String>, nil] IDs of the [connected accounts](https://docs.seam.co/core-concepts/connected-accounts) that you want to associate with the client session.
      # @param user_identifier_key [String, nil] Your user ID for the user that you want to associate with the client session.
      # @param user_identity_id [String, nil] ID of the [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) that you want to associate with the client session.
      # @param user_identity_ids [Array<String>, nil] IDs of the [user identities](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) that you want to associate with the client session.
      # @deprecated user_identity_ids: Use `user_identity_id`.
      # @return [nil] OK
      def grant_access(client_session_id: nil, connect_webview_ids: nil, connected_account_ids: nil, user_identifier_key: nil, user_identity_id: nil, user_identity_ids: nil)
        if client_session_id.nil? && connect_webview_ids.nil? && connected_account_ids.nil? && user_identifier_key.nil? && user_identity_id.nil? && user_identity_ids.nil?
          raise TypeError, "At least one parameter is required for /client_sessions/grant_access"
        end

        @client.patch("/client_sessions/grant_access", {client_session_id: client_session_id, connect_webview_ids: connect_webview_ids, connected_account_ids: connected_account_ids, user_identifier_key: user_identifier_key, user_identity_id: user_identity_id, user_identity_ids: user_identity_ids}.compact)

        nil
      end

      # Returns a list of all [client sessions](https://docs.seam.co/core-concepts/authentication/client-session-tokens).
      # @param client_session_id [String, nil] ID of the client session that you want to retrieve.
      # @param connect_webview_id [String, Seam::Null, nil] ID of the [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews) for which you want to retrieve client sessions. Specify `null` to retrieve client sessions that are not associated with a Connect Webview.
      # @param user_identifier_key [String, nil] Your user ID for the user by which you want to filter client sessions.
      # @param user_identity_id [String, Seam::Null, nil] ID of the [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) for which you want to retrieve client sessions. Specify `null` to retrieve client sessions that are not associated with a user identity.
      # @param without_user_identifier_key [Boolean, nil] Indicates whether to retrieve only client sessions without associated user identifier keys.
      # @return [Seam::Resources::ClientSession] OK
      def list(client_session_id: nil, connect_webview_id: nil, user_identifier_key: nil, user_identity_id: nil, without_user_identifier_key: nil)
        res = @client.get("/client_sessions/list", {client_session_id: client_session_id, connect_webview_id: connect_webview_id, user_identifier_key: user_identifier_key, user_identity_id: user_identity_id, without_user_identifier_key: without_user_identifier_key}.compact)

        Seam::Resources::ClientSession.load_from_response(Seam::Http::Response.read_list(res, "client_sessions", "/client_sessions/list"))
      end

      # Revokes a [client session](https://docs.seam.co/core-concepts/authentication/client-session-tokens).
      #
      # Note that [deleting a client session](https://docs.seam.co/api/client_sessions/delete) is a separate action.
      # @param client_session_id [String] ID of the client session that you want to revoke.
      # @return [nil] OK
      def revoke(client_session_id:)
        @client.post("/client_sessions/revoke", {client_session_id: client_session_id}.compact)

        nil
      end
    end
  end
end
