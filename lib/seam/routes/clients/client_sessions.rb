# frozen_string_literal: true

module Seam
  module Clients
    class ClientSessions
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create(connect_webview_ids: nil, connected_account_ids: nil, customer_id: nil, customer_key: nil, expires_at: nil, user_identifier_key: nil, user_identity_ids: nil)
        res = @client.post("/client_sessions/create", {connect_webview_ids: connect_webview_ids, connected_account_ids: connected_account_ids, customer_id: customer_id, customer_key: customer_key, expires_at: expires_at, user_identifier_key: user_identifier_key, user_identity_ids: user_identity_ids}.compact)

        Seam::Resources::ClientSession.load_from_response(res.body["client_session"])
      end

      def delete(client_session_id:)
        @client.post("/client_sessions/delete", {client_session_id: client_session_id}.compact)

        nil
      end

      def get(client_session_id: nil, user_identifier_key: nil)
        res = @client.post("/client_sessions/get", {client_session_id: client_session_id, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::ClientSession.load_from_response(res.body["client_session"])
      end

      def get_or_create(connect_webview_ids: nil, connected_account_ids: nil, expires_at: nil, user_identifier_key: nil, user_identity_ids: nil)
        res = @client.post("/client_sessions/get_or_create", {connect_webview_ids: connect_webview_ids, connected_account_ids: connected_account_ids, expires_at: expires_at, user_identifier_key: user_identifier_key, user_identity_ids: user_identity_ids}.compact)

        Seam::Resources::ClientSession.load_from_response(res.body["client_session"])
      end

      def grant_access(client_session_id: nil, connect_webview_ids: nil, connected_account_ids: nil, user_identifier_key: nil, user_identity_ids: nil)
        @client.post("/client_sessions/grant_access", {client_session_id: client_session_id, connect_webview_ids: connect_webview_ids, connected_account_ids: connected_account_ids, user_identifier_key: user_identifier_key, user_identity_ids: user_identity_ids}.compact)

        nil
      end

      def list(client_session_id: nil, connect_webview_id: nil, user_identifier_key: nil, user_identity_id: nil, without_user_identifier_key: nil)
        res = @client.post("/client_sessions/list", {client_session_id: client_session_id, connect_webview_id: connect_webview_id, user_identifier_key: user_identifier_key, user_identity_id: user_identity_id, without_user_identifier_key: without_user_identifier_key}.compact)

        Seam::Resources::ClientSession.load_from_response(res.body["client_sessions"])
      end

      def revoke(client_session_id:)
        @client.post("/client_sessions/revoke", {client_session_id: client_session_id}.compact)

        nil
      end
    end
  end
end
