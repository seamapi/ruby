# frozen_string_literal: true

module Seam
  module Clients
    class AccessCodesUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Converts an [unmanaged access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) to an [access code managed through Seam](https://docs.seam.co/low-level-apis/smart-locks/access-codes).
      #
      # An unmanaged access code has a limited set of operations that you can perform on it. Once you convert an unmanaged access code to a managed access code, the full set of access code operations and lifecycle events becomes available for it.
      #
      # Note that not all device providers support converting an unmanaged access code to a managed access code.
      # @param access_code_id [String] ID of the unmanaged access code that you want to convert to a managed access code.
      # @param allow_external_modification [Boolean, nil] Indicates whether [external modification](https://docs.seam.co/low-level-apis/smart-locks/access-codes#external-modification) of the access code is allowed.
      # @param force [Boolean, nil] Indicates whether to force the access code conversion. To switch management of an access code from one Seam workspace to another, set `force` to `true`.
      # @param is_external_modification_allowed [Boolean, nil] Indicates whether [external modification](https://docs.seam.co/low-level-apis/smart-locks/access-codes#external-modification) of the access code is allowed.
      # @return [nil] OK
      def convert_to_managed(access_code_id:, allow_external_modification: nil, force: nil, is_external_modification_allowed: nil)
        @client.post("/access_codes/unmanaged/convert_to_managed", {access_code_id: access_code_id, allow_external_modification: allow_external_modification, force: force, is_external_modification_allowed: is_external_modification_allowed}.compact)

        nil
      end

      # Deletes an [unmanaged access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes).
      # @param access_code_id [String] ID of the unmanaged access code that you want to delete.
      # @return [nil] OK
      def delete(access_code_id:)
        @client.post("/access_codes/unmanaged/delete", {access_code_id: access_code_id}.compact)

        nil
      end

      # Returns a specified [unmanaged access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes).
      #
      # You must specify either `access_code_id` or both `device_id` and `code`.
      # @param access_code_id [String, nil] ID of the unmanaged access code that you want to get. You must specify either `access_code_id` or both `device_id` and `code`.
      # @param code [String, nil] Code of the unmanaged access code that you want to get. You must specify either `access_code_id` or both `device_id` and `code`.
      # @param device_id [String, nil] ID of the device containing the unmanaged access code that you want to get. You must specify either `access_code_id` or both `device_id` and `code`.
      # @return [Seam::Resources::UnmanagedAccessCode] OK
      def get(access_code_id: nil, code: nil, device_id: nil)
        res = @client.post("/access_codes/unmanaged/get", {access_code_id: access_code_id, code: code, device_id: device_id}.compact)

        Seam::Resources::UnmanagedAccessCode.load_from_response(res.body["access_code"])
      end

      # Returns a list of all [unmanaged access codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes).
      # @param device_id [String] ID of the device for which you want to list unmanaged access codes.
      # @param limit [Float, nil] Numerical limit on the number of unmanaged access codes to return.
      # @param page_cursor [String, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search [String, nil] String for which to search. Filters returned access codes to include all records that satisfy a partial match using `name`, `code` or `access_code_id`.
      # @param user_identifier_key [String, nil] Your user ID for the user by which to filter unmanaged access codes.
      # @return [Seam::Resources::UnmanagedAccessCode] OK
      def list(device_id:, limit: nil, page_cursor: nil, search: nil, user_identifier_key: nil)
        res = @client.post("/access_codes/unmanaged/list", {device_id: device_id, limit: limit, page_cursor: page_cursor, search: search, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::UnmanagedAccessCode.load_from_response(res.body["access_codes"])
      end

      # Updates a specified [unmanaged access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes).
      # @param access_code_id [String] ID of the unmanaged access code that you want to update.
      # @param is_managed [Boolean]
      # @param allow_external_modification [Boolean, nil] Indicates whether [external modification](https://docs.seam.co/low-level-apis/smart-locks/access-codes#external-modification) of the code is allowed.
      # @param force [Boolean, nil] Indicates whether to force the unmanaged access code update.
      # @param is_external_modification_allowed [Boolean, nil] Indicates whether [external modification](https://docs.seam.co/low-level-apis/smart-locks/access-codes#external-modification) of the code is allowed.
      # @return [nil] OK
      def update(access_code_id:, is_managed:, allow_external_modification: nil, force: nil, is_external_modification_allowed: nil)
        @client.post("/access_codes/unmanaged/update", {access_code_id: access_code_id, is_managed: is_managed, allow_external_modification: allow_external_modification, force: force, is_external_modification_allowed: is_external_modification_allowed}.compact)

        nil
      end
    end
  end
end
