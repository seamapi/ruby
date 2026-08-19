# frozen_string_literal: true

module Seam
  module Clients
    class AccessCodes
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def simulate
        @simulate ||= Seam::Clients::AccessCodesSimulate.new(client: @client, defaults: @defaults)
      end

      def unmanaged
        @unmanaged ||= Seam::Clients::AccessCodesUnmanaged.new(client: @client, defaults: @defaults)
      end

      # Creates a new [access code](https://docs.seam.co/low-level-apis/access-codes). For granting access, we recommend [Access Grants](https://docs.seam.co/use-cases/granting-access) instead: they work across both standalone smart locks and access control systems and manage the underlying codes for you. Use this low-level endpoint only when you need direct control over a code on a single device, such as setting a custom PIN value.
      # @param device_id [String] ID of the device for which you want to create the new access code.
      # @param allow_external_modification [Boolean, nil] Indicates whether [external modification](https://docs.seam.co/low-level-apis/smart-locks/access-codes#external-modification) of the code is allowed. Default: `false`.
      # @param attempt_for_offline_device [Boolean, nil]
      # @param code [String, nil] Code to be used for access.
      # @param common_code_key [String, nil] Key to identify access codes that should have the same code. Any two access codes with the same `common_code_key` are guaranteed to have the same `code`. See also [Creating and Updating Multiple Linked Access Codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/creating-and-updating-multiple-linked-access-codes).
      # @param ends_at [String, nil] Date and time at which the validity of the new access code ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Must be a time in the future and after `starts_at`.
      # @param is_external_modification_allowed [Boolean, nil] Indicates whether [external modification](https://docs.seam.co/low-level-apis/smart-locks/access-codes#external-modification) of the code is allowed. Default: `false`.
      # @param is_offline_access_code [Boolean, nil] Indicates whether the access code is an [offline access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/offline-access-codes).
      # @param is_one_time_use [Boolean, nil] Indicates whether the [offline access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/offline-access-codes) is a single-use access code.
      # @param max_time_rounding [String, nil] Maximum rounding adjustment. To create a daily-bound [offline access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/offline-access-codes) for devices that support this feature, set this parameter to `1d`.
      # @param name [String, nil] Name of the new access code. Enables administrators and users to identify the access code easily, especially when there are numerous access codes.
      #
      # Note that the name provided on Seam is used to identify the code on Seam and is not necessarily the name that will appear in the lock provider's app or on the device. This is because lock providers may have constraints on names, such as length, uniqueness, or characters that can be used. In addition, some lock providers may break down names into components such as `first_name` and `last_name`.
      #
      # To provide a consistent experience, Seam identifies the code on Seam by its name but may modify the name that appears on the lock provider's app or on the device. For example, Seam may add additional characters or truncate the name to meet provider constraints.
      #
      # To help your users identify codes set by Seam, Seam provides the name exactly as it appears on the lock provider's app or on the device as a separate property called `appearance`. This is an object with a `name` property and, optionally, `first_name` and `last_name` properties (for providers that break down a name into components).
      # @param prefer_native_scheduling [Boolean, nil] Indicates whether [native scheduling](https://docs.seam.co/low-level-apis/smart-locks/access-codes#native-scheduling) should be used for time-bound codes when supported by the provider. Default: `true`.
      # @param preferred_code_length [Float, nil] Preferred code length. Only applicable if you do not specify a `code`. If the affected device does not support the preferred code length, Seam reverts to using the shortest supported code length.
      # @param starts_at [String, nil] Date and time at which the validity of the new access code starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @param use_backup_access_code_pool [Boolean, nil] Indicates whether to use a [backup access code pool](https://docs.seam.co/low-level-apis/smart-locks/access-codes/backup-access-codes) provided by Seam. If `true`, you can use [`/access_codes/pull_backup_access_code`](https://docs.seam.co/api/access_codes/pull_backup_access_code).
      # @param use_offline_access_code [Boolean, nil]
      # @deprecated use_offline_access_code: Use `is_offline_access_code` instead.
      # @return [Seam::Resources::AccessCode] OK
      def create(device_id:, allow_external_modification: nil, attempt_for_offline_device: nil, code: nil, common_code_key: nil, ends_at: nil, is_external_modification_allowed: nil, is_offline_access_code: nil, is_one_time_use: nil, max_time_rounding: nil, name: nil, prefer_native_scheduling: nil, preferred_code_length: nil, starts_at: nil, use_backup_access_code_pool: nil, use_offline_access_code: nil)
        res = @client.post("/access_codes/create", {device_id: device_id, allow_external_modification: allow_external_modification, attempt_for_offline_device: attempt_for_offline_device, code: code, common_code_key: common_code_key, ends_at: ends_at, is_external_modification_allowed: is_external_modification_allowed, is_offline_access_code: is_offline_access_code, is_one_time_use: is_one_time_use, max_time_rounding: max_time_rounding, name: name, prefer_native_scheduling: prefer_native_scheduling, preferred_code_length: preferred_code_length, starts_at: starts_at, use_backup_access_code_pool: use_backup_access_code_pool, use_offline_access_code: use_offline_access_code}.compact)

        Seam::Resources::AccessCode.load_from_response(res.body["access_code"])
      end

      # Creates new [access codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes) that share a common code across multiple devices.
      #
      # Users with more than one door lock in a property may want to create groups of linked access codes, all of which have the same code (PIN). For example, a short-term rental host may want to provide guests the same PIN for both a front door lock and a back door lock.
      #
      # If you specify a custom code, Seam assigns this custom code to each of the resulting access codes. However, in this case, Seam does not link these access codes together with a `common_code_key`. That is, `common_code_key` remains null for these access codes.
      #
      # If you want to change these access codes that are not linked by a `common_code_key`, you cannot use `/access_codes/update_multiple`. However, you can update each of these access codes individually, using `/access_codes/update`.
      #
      # See also [Creating and Updating Multiple Linked Access Codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/creating-and-updating-multiple-linked-access-codes).
      #
      # For granting a person access to a space, [Access Grants](https://docs.seam.co/use-cases/granting-access) are the default and recommended approach and work across both standalone smart locks and access systems. Use the lower-level Access Codes API directly only when you specifically need to manage individual PIN codes.
      # @param device_ids [Array<String>] IDs of the devices for which you want to create the new access codes.
      # @param allow_external_modification [Boolean, nil] Indicates whether [external modification](https://docs.seam.co/low-level-apis/smart-locks/access-codes#external-modification) of the code is allowed. Default: `false`.
      # @param attempt_for_offline_device [Boolean, nil]
      # @param behavior_when_code_cannot_be_shared [String, nil] Desired behavior if any device cannot share a code. If `throw` (default), no access codes will be created if any device cannot share a code. If `create_random_code`, a random code will be created on devices that cannot share a code.
      # @param code [String, nil] Code to be used for access.
      # @param ends_at [String, nil] Date and time at which the validity of the new access code ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Must be a time in the future and after `starts_at`.
      # @param is_external_modification_allowed [Boolean, nil] Indicates whether [external modification](https://docs.seam.co/low-level-apis/smart-locks/access-codes#external-modification) of the code is allowed. Default: `false`.
      # @param name [String, nil] Name of the new access code. Enables administrators and users to identify the access code easily, especially when there are numerous access codes.
      #
      # Note that the name provided on Seam is used to identify the code on Seam and is not necessarily the name that will appear in the lock provider's app or on the device. This is because lock providers may have constraints on names, such as length, uniqueness, or characters that can be used. In addition, some lock providers may break down names into components such as `first_name` and `last_name`.
      #
      # To provide a consistent experience, Seam identifies the code on Seam by its name but may modify the name that appears on the lock provider's app or on the device. For example, Seam may add additional characters or truncate the name to meet provider constraints.
      #
      # To help your users identify codes set by Seam, Seam provides the name exactly as it appears on the lock provider's app or on the device as a separate property called `appearance`. This is an object with a `name` property and, optionally, `first_name` and `last_name` properties (for providers that break down a name into components).
      # @param prefer_native_scheduling [Boolean, nil] Indicates whether [native scheduling](https://docs.seam.co/low-level-apis/smart-locks/access-codes#native-scheduling) should be used for time-bound codes when supported by the provider. Default: `true`.
      # @param preferred_code_length [Float, nil] Preferred code length. If the affected devices do not support the preferred code length, Seam reverts to using the shortest supported code length.
      # @param starts_at [String, nil] Date and time at which the validity of the new access code starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @param use_backup_access_code_pool [Boolean, nil] Indicates whether to use a [backup access code pool](https://docs.seam.co/low-level-apis/smart-locks/access-codes/backup-access-codes) provided by Seam. If `true`, you can use [`/access_codes/pull_backup_access_code`](https://docs.seam.co/api/access_codes/pull_backup_access_code).
      # @return [Seam::Resources::AccessCode] OK
      def create_multiple(device_ids:, allow_external_modification: nil, attempt_for_offline_device: nil, behavior_when_code_cannot_be_shared: nil, code: nil, ends_at: nil, is_external_modification_allowed: nil, name: nil, prefer_native_scheduling: nil, preferred_code_length: nil, starts_at: nil, use_backup_access_code_pool: nil)
        res = @client.put("/access_codes/create_multiple", {device_ids: device_ids, allow_external_modification: allow_external_modification, attempt_for_offline_device: attempt_for_offline_device, behavior_when_code_cannot_be_shared: behavior_when_code_cannot_be_shared, code: code, ends_at: ends_at, is_external_modification_allowed: is_external_modification_allowed, name: name, prefer_native_scheduling: prefer_native_scheduling, preferred_code_length: preferred_code_length, starts_at: starts_at, use_backup_access_code_pool: use_backup_access_code_pool}.compact)

        Seam::Resources::AccessCode.load_from_response(res.body["access_codes"])
      end

      # Deletes an [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes).
      # @param access_code_id [String] ID of the access code that you want to delete.
      # @param device_id [String, nil] ID of the device for which you want to delete the access code.
      # @return [nil] OK
      def delete(access_code_id:, device_id: nil)
        @client.delete("/access_codes/delete", {access_code_id: access_code_id, device_id: device_id}.compact)

        nil
      end

      # Generates a code for an [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes), given a device ID.
      # @param device_id [String] ID of the device for which you want to generate a code.
      # @return [Seam::Resources::AccessCode] OK
      def generate_code(device_id:)
        res = @client.get("/access_codes/generate_code", {device_id: device_id}.compact)

        Seam::Resources::AccessCode.load_from_response(res.body["generated_code"])
      end

      # Returns a specified [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes).
      #
      # You must specify either `access_code_id` or both `device_id` and `code`.
      # @param access_code_id [String, nil] ID of the access code that you want to get. You must specify either `access_code_id` or both `device_id` and `code`.
      # @param code [String, nil] Code of the access code that you want to get. You must specify either `access_code_id` or both `device_id` and `code`.
      # @param device_id [String, nil] ID of the device containing the access code that you want to get. You must specify either `access_code_id` or both `device_id` and `code`.
      # @return [Seam::Resources::AccessCode] OK
      def get(access_code_id: nil, code: nil, device_id: nil)
        if access_code_id.nil? && code.nil? && device_id.nil?
          raise TypeError, "At least one parameter is required for /access_codes/get"
        end

        res = @client.get("/access_codes/get", {access_code_id: access_code_id, code: code, device_id: device_id}.compact)

        Seam::Resources::AccessCode.load_from_response(res.body["access_code"])
      end

      # Returns a list of all [access codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes).
      #
      # Specify `device_id`, `access_code_ids`, `access_method_id`, `access_grant_id`, or `access_grant_key`.
      # @param access_code_ids [Array<String>, nil] IDs of the access codes that you want to retrieve. Specify `device_id`, `access_code_ids`, `access_method_id`, `access_grant_id`, or `access_grant_key`.
      # @param access_grant_id [String, nil] ID of the access grant for which you want to list access codes. Specify `device_id`, `access_code_ids`, `access_method_id`, `access_grant_id`, or `access_grant_key`.
      # @param access_grant_key [String, nil] Key of the access grant for which you want to list access codes. Specify `device_id`, `access_code_ids`, `access_method_id`, `access_grant_id`, or `access_grant_key`.
      # @param access_method_id [String, nil] ID of the access method for which you want to list access codes. Specify `device_id`, `access_code_ids`, `access_method_id`, `access_grant_id`, or `access_grant_key`.
      # @param customer_key [String, nil] Customer key for which you want to list access codes.
      # @param device_id [String, nil] ID of the device for which you want to list access codes. Specify `device_id`, `access_code_ids`, `access_method_id`, `access_grant_id`, or `access_grant_key`.
      # @param limit [Float, nil] Numerical limit on the number of access codes to return.
      # @param page_cursor [String, Seam::Null, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search [String, nil] String for which to search. Filters returned access codes to include all records that satisfy a partial match using `name`, `code` or `access_code_id`.
      # @param user_identifier_key [String, nil] Your user ID for the user by which to filter access codes.
      # @return [Seam::Resources::AccessCode] OK
      def list(access_code_ids: nil, access_grant_id: nil, access_grant_key: nil, access_method_id: nil, customer_key: nil, device_id: nil, limit: nil, page_cursor: nil, search: nil, user_identifier_key: nil)
        if access_code_ids.nil? && access_grant_id.nil? && access_grant_key.nil? && access_method_id.nil? && customer_key.nil? && device_id.nil? && limit.nil? && page_cursor.nil? && search.nil? && user_identifier_key.nil?
          raise TypeError, "At least one parameter is required for /access_codes/list"
        end

        res = @client.get("/access_codes/list", {access_code_ids: access_code_ids, access_grant_id: access_grant_id, access_grant_key: access_grant_key, access_method_id: access_method_id, customer_key: customer_key, device_id: device_id, limit: limit, page_cursor: page_cursor, search: search, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::AccessCode.load_from_response(res.body["access_codes"])
      end

      # Retrieves a backup access code for an [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes). See also [Managing Backup Access Codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/backup-access-codes).
      #
      # A backup access code pool is a collection of pre-programmed access codes stored on a device, ready for use. These codes are programmed in addition to the regular access codes on Seam, serving as a safety net for any issues with the primary codes. If there's ever a complication with a primary access code—be it due to intermittent connectivity, manual removal from a device, or provider outages—a backup code can be retrieved. Its end time can then be adjusted to align with the original code, facilitating seamless and uninterrupted access.
      #
      # You can pull a backup access code from the pool at any time. These backup codes are guaranteed to work immediately and automatically programmed to be removed from the device after the access code ends.
      #
      # You can only pull backup access codes for time-bound access codes.
      #
      # Before pulling a backup access code, make sure that the device's `properties.supports_backup_access_code_pool` is `true`. Then, to activate the backup pool, set `use_backup_access_code_pool` to `true` when creating an access code.
      # @param access_code_id [String] ID of the access code for which you want to pull a backup access code.
      # @return [Seam::Resources::AccessCode] OK
      def pull_backup_access_code(access_code_id:)
        res = @client.post("/access_codes/pull_backup_access_code", {access_code_id: access_code_id}.compact)

        Seam::Resources::AccessCode.load_from_response(res.body["access_code"])
      end

      # Enables you to report access code-related constraints for a device. Currently, supports reporting supported code length constraints for SmartThings devices.
      #
      # Specify either `supported_code_lengths` or `min_code_length`/`max_code_length`.
      # @param device_id [String] ID of the device for which you want to report constraints.
      # @param max_code_length [Integer, nil] Maximum supported code length as an integer between 4 and 20, inclusive. You can specify either `min_code_length`/`max_code_length` or `supported_code_lengths`.
      # @param min_code_length [Integer, nil] Minimum supported code length as an integer between 4 and 20, inclusive. You can specify either `min_code_length`/`max_code_length` or `supported_code_lengths`.
      # @param supported_code_lengths [Array<Integer>, nil] Array of supported code lengths as integers between 4 and 20, inclusive. You can specify either `supported_code_lengths` or `min_code_length`/`max_code_length`.
      # @return [nil] OK
      def report_device_constraints(device_id:, max_code_length: nil, min_code_length: nil, supported_code_lengths: nil)
        @client.post("/access_codes/report_device_constraints", {device_id: device_id, max_code_length: max_code_length, min_code_length: min_code_length, supported_code_lengths: supported_code_lengths}.compact)

        nil
      end

      # Updates a specified active or upcoming [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes).
      #
      # See also [Modifying Access Codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/modifying-access-codes).
      # @param access_code_id [String] ID of the access code that you want to update.
      # @param allow_external_modification [Boolean, nil] Indicates whether [external modification](https://docs.seam.co/low-level-apis/smart-locks/access-codes#external-modification) of the code is allowed. Default: `false`.
      # @param attempt_for_offline_device [Boolean, nil]
      # @param code [String, nil] Code to be used for access.
      # @param device_id [String, nil] ID of the device containing the access code that you want to update.
      # @param ends_at [String, nil] Date and time at which the validity of the new access code ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Must be a time in the future and after `starts_at`.
      # @param is_external_modification_allowed [Boolean, nil] Indicates whether [external modification](https://docs.seam.co/low-level-apis/smart-locks/access-codes#external-modification) of the code is allowed. Default: `false`.
      # @param is_managed [Boolean, nil] Indicates whether the access code is managed through Seam. Note that to convert an unmanaged access code into a managed access code, use `/access_codes/unmanaged/convert_to_managed`.
      # @param name [String, nil] Name of the new access code. Enables administrators and users to identify the access code easily, especially when there are numerous access codes.
      #
      # Note that the name provided on Seam is used to identify the code on Seam and is not necessarily the name that will appear in the lock provider's app or on the device. This is because lock providers may have constraints on names, such as length, uniqueness, or characters that can be used. In addition, some lock providers may break down names into components such as `first_name` and `last_name`.
      #
      # To provide a consistent experience, Seam identifies the code on Seam by its name but may modify the name that appears on the lock provider's app or on the device. For example, Seam may add additional characters or truncate the name to meet provider constraints.
      #
      # To help your users identify codes set by Seam, Seam provides the name exactly as it appears on the lock provider's app or on the device as a separate property called `appearance`. This is an object with a `name` property and, optionally, `first_name` and `last_name` properties (for providers that break down a name into components).
      # @param starts_at [String, nil] Date and time at which the validity of the new access code starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @param type [String, nil] Type to which you want to convert the access code. To convert a time-bound access code to an ongoing access code, set `type` to `ongoing`. See also [Changing a time-bound access code to permanent access](https://docs.seam.co/low-level-apis/smart-locks/access-codes/modifying-access-codes#special-case-2-changing-a-time-bound-access-code-to-permanent-access).
      # @return [nil] OK
      def update(access_code_id:, allow_external_modification: nil, attempt_for_offline_device: nil, code: nil, device_id: nil, ends_at: nil, is_external_modification_allowed: nil, is_managed: nil, name: nil, starts_at: nil, type: nil)
        @client.put("/access_codes/update", {access_code_id: access_code_id, allow_external_modification: allow_external_modification, attempt_for_offline_device: attempt_for_offline_device, code: code, device_id: device_id, ends_at: ends_at, is_external_modification_allowed: is_external_modification_allowed, is_managed: is_managed, name: name, starts_at: starts_at, type: type}.compact)

        nil
      end

      # Updates [access codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes) that share a common code across multiple devices.
      #
      # Specify the `common_code_key` to identify the set of access codes that you want to update.
      #
      # See also [Update Linked Access Codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/creating-and-updating-multiple-linked-access-codes#update-linked-access-codes).
      # @param common_code_key [String] Key that links the group of access codes, assigned on creation by `/access_codes/create_multiple`.
      # @param ends_at [String, nil] Date and time at which the validity of the new access code ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Must be a time in the future and after `starts_at`.
      # @param name [String, nil] Name of the new access code. Enables administrators and users to identify the access code easily, especially when there are numerous access codes.
      #
      # Note that the name provided on Seam is used to identify the code on Seam and is not necessarily the name that will appear in the lock provider's app or on the device. This is because lock providers may have constraints on names, such as length, uniqueness, or characters that can be used. In addition, some lock providers may break down names into components such as `first_name` and `last_name`.
      #
      # To provide a consistent experience, Seam identifies the code on Seam by its name but may modify the name that appears on the lock provider's app or on the device. For example, Seam may add additional characters or truncate the name to meet provider constraints.
      #
      # To help your users identify codes set by Seam, Seam provides the name exactly as it appears on the lock provider's app or on the device as a separate property called `appearance`. This is an object with a `name` property and, optionally, `first_name` and `last_name` properties (for providers that break down a name into components).
      # @param starts_at [String, nil] Date and time at which the validity of the new access code starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @return [nil] OK
      def update_multiple(common_code_key:, ends_at: nil, name: nil, starts_at: nil)
        @client.patch("/access_codes/update_multiple", {common_code_key: common_code_key, ends_at: ends_at, name: name, starts_at: starts_at}.compact)

        nil
      end
    end
  end
end
