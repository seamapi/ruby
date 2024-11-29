# frozen_string_literal: true

module Seam
  module Clients
    class AcsCredentials
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def assign(acs_credential_id:, acs_user_id:)
        @client.post("/acs/credentials/assign", {acs_credential_id: acs_credential_id, acs_user_id: acs_user_id}.compact)

        nil
      end

      def create(access_method:, acs_user_id:, allowed_acs_entrance_ids: nil, assa_abloy_vostio_metadata: nil, code: nil, credential_manager_acs_system_id: nil, ends_at: nil, is_multi_phone_sync_credential: nil, starts_at: nil, visionline_metadata: nil)
        res = @client.post("/acs/credentials/create", {access_method: access_method, acs_user_id: acs_user_id, allowed_acs_entrance_ids: allowed_acs_entrance_ids, assa_abloy_vostio_metadata: assa_abloy_vostio_metadata, code: code, credential_manager_acs_system_id: credential_manager_acs_system_id, ends_at: ends_at, is_multi_phone_sync_credential: is_multi_phone_sync_credential, starts_at: starts_at, visionline_metadata: visionline_metadata}.compact)

        Seam::Resources::AcsCredential.load_from_response(res.body["acs_credential"])
      end

      def create_offline_code(acs_user_id:, allowed_acs_entrance_id:, ends_at: nil, is_one_time_use: nil, starts_at: nil)
        res = @client.post("/acs/credentials/create_offline_code", {acs_user_id: acs_user_id, allowed_acs_entrance_id: allowed_acs_entrance_id, ends_at: ends_at, is_one_time_use: is_one_time_use, starts_at: starts_at}.compact)

        Seam::Resources::AcsCredential.load_from_response(res.body["acs_credential"])
      end

      def delete(acs_credential_id:)
        @client.post("/acs/credentials/delete", {acs_credential_id: acs_credential_id}.compact)

        nil
      end

      def get(acs_credential_id:)
        res = @client.post("/acs/credentials/get", {acs_credential_id: acs_credential_id}.compact)

        Seam::Resources::AcsCredential.load_from_response(res.body["acs_credential"])
      end

      def list(acs_user_id: nil, acs_system_id: nil, user_identity_id: nil, created_before: nil, is_multi_phone_sync_credential: nil, limit: nil)
        res = @client.post("/acs/credentials/list", {acs_user_id: acs_user_id, acs_system_id: acs_system_id, user_identity_id: user_identity_id, created_before: created_before, is_multi_phone_sync_credential: is_multi_phone_sync_credential, limit: limit}.compact)

        Seam::Resources::AcsCredential.load_from_response(res.body["acs_credentials"])
      end

      def list_accessible_entrances(acs_credential_id:)
        res = @client.post("/acs/credentials/list_accessible_entrances", {acs_credential_id: acs_credential_id}.compact)

        Seam::Resources::AcsEntrance.load_from_response(res.body["acs_entrances"])
      end

      def unassign(acs_credential_id:, acs_user_id:)
        @client.post("/acs/credentials/unassign", {acs_credential_id: acs_credential_id, acs_user_id: acs_user_id}.compact)

        nil
      end

      def update(acs_credential_id:, code: nil, ends_at: nil)
        @client.post("/acs/credentials/update", {acs_credential_id: acs_credential_id, code: code, ends_at: ends_at}.compact)

        nil
      end
    end
  end
end
