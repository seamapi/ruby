# frozen_string_literal: true

module Seam
  module Clients
    class AccessCodesUnmanaged < BaseClient
      def convert_to_managed(access_code_id:, allow_external_modification: nil, force: nil, is_external_modification_allowed: nil, sync: nil)
        request_seam(
          :post,
          "/access_codes/unmanaged/convert_to_managed",
          body: {access_code_id: access_code_id, allow_external_modification: allow_external_modification, force: force, is_external_modification_allowed: is_external_modification_allowed, sync: sync}.compact
        )

        nil
      end

      def delete(access_code_id:, sync: nil)
        request_seam(
          :post,
          "/access_codes/unmanaged/delete",
          body: {access_code_id: access_code_id, sync: sync}.compact
        )

        nil
      end

      def get(access_code_id: nil, code: nil, device_id: nil)
        request_seam_object(
          :post,
          "/access_codes/unmanaged/get",
          Seam::UnmanagedAccessCode,
          "access_code",
          body: {access_code_id: access_code_id, code: code, device_id: device_id}.compact
        )
      end

      def list(device_id:, user_identifier_key: nil)
        request_seam_object(
          :post,
          "/access_codes/unmanaged/list",
          Seam::UnmanagedAccessCode,
          "access_codes",
          body: {device_id: device_id, user_identifier_key: user_identifier_key}.compact
        )
      end

      def update(access_code_id:, is_managed:, allow_external_modification: nil, force: nil, is_external_modification_allowed: nil)
        request_seam(
          :post,
          "/access_codes/unmanaged/update",
          body: {access_code_id: access_code_id, is_managed: is_managed, allow_external_modification: allow_external_modification, force: force, is_external_modification_allowed: is_external_modification_allowed}.compact
        )

        nil
      end
    end
  end
end
