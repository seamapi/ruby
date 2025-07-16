# frozen_string_literal: true

module Seam
  module Clients
    class AccessCodesUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def convert_to_managed(access_code_id:, allow_external_modification: nil, force: nil, is_external_modification_allowed: nil, sync: nil)
        @client.post("/access_codes/unmanaged/convert_to_managed", {access_code_id: access_code_id, allow_external_modification: allow_external_modification, force: force, is_external_modification_allowed: is_external_modification_allowed, sync: sync}.compact)

        nil
      end

      def delete(access_code_id:, sync: nil)
        @client.post("/access_codes/unmanaged/delete", {access_code_id: access_code_id, sync: sync}.compact)

        nil
      end

      def get(access_code_id: nil, code: nil, device_id: nil)
        res = @client.post("/access_codes/unmanaged/get", {access_code_id: access_code_id, code: code, device_id: device_id}.compact)

        Seam::Resources::UnmanagedAccessCode.load_from_response(res.body["access_code"])
      end

      def list(device_id:, limit: nil, page_cursor: nil, user_identifier_key: nil)
        res = @client.post("/access_codes/unmanaged/list", {device_id: device_id, limit: limit, page_cursor: page_cursor, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::UnmanagedAccessCode.load_from_response(res.body["access_codes"])
      end

      def update(access_code_id:, is_managed:, allow_external_modification: nil, force: nil, is_external_modification_allowed: nil)
        @client.post("/access_codes/unmanaged/update", {access_code_id: access_code_id, is_managed: is_managed, allow_external_modification: allow_external_modification, force: force, is_external_modification_allowed: is_external_modification_allowed}.compact)

        nil
      end
    end
  end
end
