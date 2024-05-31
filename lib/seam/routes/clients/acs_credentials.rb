# frozen_string_literal: true

module Seam
  module Clients
    class AcsCredentials < BaseClient
      def assign(acs_credential_id:, acs_user_id:)
        request_seam(
          :post,
          "/acs/credentials/assign",
          body: {acs_credential_id: acs_credential_id, acs_user_id: acs_user_id}.compact
        )

        nil
      end

      def create(access_method:, acs_user_id:, allowed_acs_entrance_ids: nil, code: nil, credential_manager_acs_system_id: nil, ends_at: nil, is_multi_phone_sync_credential: nil, starts_at: nil, visionline_metadata: nil)
        request_seam_object(
          :post,
          "/acs/credentials/create",
          Seam::AcsCredential,
          "acs_credential",
          body: {access_method: access_method, acs_user_id: acs_user_id, allowed_acs_entrance_ids: allowed_acs_entrance_ids, code: code, credential_manager_acs_system_id: credential_manager_acs_system_id, ends_at: ends_at, is_multi_phone_sync_credential: is_multi_phone_sync_credential, starts_at: starts_at, visionline_metadata: visionline_metadata}.compact
        )
      end

      def delete(acs_credential_id:)
        request_seam(
          :post,
          "/acs/credentials/delete",
          body: {acs_credential_id: acs_credential_id}.compact
        )

        nil
      end

      def get(acs_credential_id:)
        request_seam_object(
          :post,
          "/acs/credentials/get",
          Seam::AcsCredential,
          "acs_credential",
          body: {acs_credential_id: acs_credential_id}.compact
        )
      end

      def list(acs_user_id: nil, acs_system_id: nil, user_identity_id: nil, is_multi_phone_sync_credential: nil)
        request_seam_object(
          :post,
          "/acs/credentials/list",
          Seam::AcsCredential,
          "acs_credentials",
          body: {acs_user_id: acs_user_id, acs_system_id: acs_system_id, user_identity_id: user_identity_id, is_multi_phone_sync_credential: is_multi_phone_sync_credential}.compact
        )
      end

      def list_accessible_entrances(acs_credential_id:)
        request_seam_object(
          :post,
          "/acs/credentials/list_accessible_entrances",
          Seam::AcsEntrance,
          "acs_entrances",
          body: {acs_credential_id: acs_credential_id}.compact
        )
      end

      def unassign(acs_credential_id:, acs_user_id:)
        request_seam(
          :post,
          "/acs/credentials/unassign",
          body: {acs_credential_id: acs_credential_id, acs_user_id: acs_user_id}.compact
        )

        nil
      end

      def update(acs_credential_id:, code: nil, ends_at: nil)
        request_seam(
          :post,
          "/acs/credentials/update",
          body: {acs_credential_id: acs_credential_id, code: code, ends_at: ends_at}.compact
        )

        nil
      end
    end
  end
end
