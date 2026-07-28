# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class Locks
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def simulate
        @simulate ||= Seam::Clients::LocksSimulate.new(client: @client, defaults: @defaults)
      end

      # Configures the auto-lock setting for a specified [lock](https://docs.seam.co/low-level-apis/smart-locks).
      # @param auto_lock_enabled Whether to enable or disable auto-lock.
      # @param device_id ID of the lock for which you want to configure the auto-lock.
      # @param auto_lock_delay_seconds Delay in seconds before the lock automatically locks. Required when enabling auto-lock. Must be between 1 and 60.
      # @return [Seam::Resources::ActionAttempt] OK
      def configure_auto_lock(auto_lock_enabled:, device_id:, auto_lock_delay_seconds: nil, wait_for_action_attempt: nil)
        res = @client.post("/locks/configure_auto_lock", {auto_lock_enabled: auto_lock_enabled, device_id: device_id, auto_lock_delay_seconds: auto_lock_delay_seconds}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Returns a specified [lock](https://docs.seam.co/low-level-apis/smart-locks).
      # @param device_id ID of the lock that you want to get.
      # @param name Name of the lock that you want to get.
      # @return [Seam::Resources::Device] OK
      # @deprecated Use `/devices/get` instead.
      def get(device_id: nil, name: nil)
        res = @client.post("/locks/get", {device_id: device_id, name: name}.compact)

        Seam::Resources::Device.load_from_response(res.body["device"])
      end

      # Returns a list of all [locks](https://docs.seam.co/low-level-apis/smart-locks).
      # @param connect_webview_id ID of the Connect Webview for which you want to list devices.
      # @param connected_account_id ID of the connected account for which you want to list devices.
      # @param connected_account_ids Array of IDs of the connected accounts for which you want to list devices.
      # @param created_before Timestamp by which to limit returned devices. Returns devices created before this timestamp.
      # @param custom_metadata_has Set of key:value [custom metadata](https://docs.seam.co/core-concepts/devices/adding-custom-metadata-to-a-device) pairs for which you want to list devices.
      # @param customer_key Customer key for which you want to list devices.
      # @param device_ids Array of device IDs for which you want to list devices.
      # @param device_type Device type of the locks that you want to list.
      # @param device_types Device types of the locks that you want to list.
      # @param limit Numerical limit on the number of devices to return.
      # @param manufacturer Manufacturer of the locks that you want to list.
      # @param page_cursor Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search String for which to search. Filters returned devices to include all records that satisfy a partial match using `device_id` (full or partial UUID prefix, minimum 4 characters), `connected_account_id`, `display_name`, `custom_metadata` or `location.location_name`.
      # @param space_id ID of the space for which you want to list devices.
      # @param unstable_location_id Deprecated: Use `space_id`.
      # @param user_identifier_key Your own internal user ID for the user for which you want to list devices.
      # @return [Seam::Resources::Device] OK
      def list(connect_webview_id: nil, connected_account_id: nil, connected_account_ids: nil, created_before: nil, custom_metadata_has: nil, customer_key: nil, device_ids: nil, device_type: nil, device_types: nil, limit: nil, manufacturer: nil, page_cursor: nil, search: nil, space_id: nil, unstable_location_id: nil, user_identifier_key: nil)
        res = @client.post("/locks/list", {connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, connected_account_ids: connected_account_ids, created_before: created_before, custom_metadata_has: custom_metadata_has, customer_key: customer_key, device_ids: device_ids, device_type: device_type, device_types: device_types, limit: limit, manufacturer: manufacturer, page_cursor: page_cursor, search: search, space_id: space_id, unstable_location_id: unstable_location_id, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::Device.load_from_response(res.body["devices"])
      end

      # Locks a [lock](https://docs.seam.co/low-level-apis/smart-locks). See also [Locking and Unlocking Smart Locks](https://docs.seam.co/low-level-apis/smart-locks/lock-and-unlock).
      # @param device_id ID of the lock that you want to lock.
      # @return [Seam::Resources::ActionAttempt] OK
      def lock_door(device_id:, wait_for_action_attempt: nil)
        res = @client.post("/locks/lock_door", {device_id: device_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Unlocks a [lock](https://docs.seam.co/low-level-apis/smart-locks). See also [Locking and Unlocking Smart Locks](https://docs.seam.co/low-level-apis/smart-locks/lock-and-unlock).
      # @param device_id ID of the lock that you want to unlock.
      # @return [Seam::Resources::ActionAttempt] OK
      def unlock_door(device_id:, wait_for_action_attempt: nil)
        res = @client.post("/locks/unlock_door", {device_id: device_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end
    end
  end
end
