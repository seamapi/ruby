# frozen_string_literal: true

module Seam
  module Clients
    class ClientSessions < BaseClient
      def create(connect_webview_ids: nil, connected_account_ids: nil, expires_at: nil, user_identifier_key: nil, user_identity_ids: nil)
        request_seam_object(
          :post,
          "/client_sessions/create",
          Seam::Resources::ClientSession,
          "client_session",
          body: {connect_webview_ids: connect_webview_ids, connected_account_ids: connected_account_ids, expires_at: expires_at, user_identifier_key: user_identifier_key, user_identity_ids: user_identity_ids}.compact
        )
      end

      def delete(client_session_id:)
        request_seam(
          :post,
          "/client_sessions/delete",
          body: {client_session_id: client_session_id}.compact
        )

        nil
      end

      def get(client_session_id: nil, user_identifier_key: nil)
        request_seam_object(
          :post,
          "/client_sessions/get",
          Seam::Resources::ClientSession,
          "client_session",
          body: {client_session_id: client_session_id, user_identifier_key: user_identifier_key}.compact
        )
      end

      def get_or_create(connect_webview_ids: nil, connected_account_ids: nil, expires_at: nil, user_identifier_key: nil, user_identity_ids: nil)
        request_seam_object(
          :post,
          "/client_sessions/get_or_create",
          Seam::Resources::ClientSession,
          "client_session",
          body: {connect_webview_ids: connect_webview_ids, connected_account_ids: connected_account_ids, expires_at: expires_at, user_identifier_key: user_identifier_key, user_identity_ids: user_identity_ids}.compact
        )
      end

      def grant_access(client_session_id: nil, connect_webview_ids: nil, connected_account_ids: nil, user_identifier_key: nil, user_identity_ids: nil)
        request_seam(
          :post,
          "/client_sessions/grant_access",
          body: {client_session_id: client_session_id, connect_webview_ids: connect_webview_ids, connected_account_ids: connected_account_ids, user_identifier_key: user_identifier_key, user_identity_ids: user_identity_ids}.compact
        )

        nil
      end

      def list(client_session_id: nil, connect_webview_id: nil, user_identifier_key: nil, user_identity_id: nil, without_user_identifier_key: nil)
        request_seam_object(
          :post,
          "/client_sessions/list",
          Seam::Resources::ClientSession,
          "client_sessions",
          body: {client_session_id: client_session_id, connect_webview_id: connect_webview_id, user_identifier_key: user_identifier_key, user_identity_id: user_identity_id, without_user_identifier_key: without_user_identifier_key}.compact
        )
      end

      def revoke(client_session_id:)
        request_seam(
          :post,
          "/client_sessions/revoke",
          body: {client_session_id: client_session_id}.compact
        )

        nil
      end
    end
  end
end
