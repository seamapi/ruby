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
      # @param auto_lock_enabled [Boolean] Whether to enable or disable auto-lock.
      # @param device_id [String] ID of the lock for which you want to configure the auto-lock.
      # @param auto_lock_delay_seconds [Float, nil] Delay in seconds before the lock automatically locks. Required when enabling auto-lock. Must be between 1 and 60.
      # @return [Seam::Resources::ActionAttempt] OK
      def configure_auto_lock(auto_lock_enabled:, device_id:, auto_lock_delay_seconds: nil, wait_for_action_attempt: nil)
        res = @client.post("/locks/configure_auto_lock", {auto_lock_enabled: auto_lock_enabled, device_id: device_id, auto_lock_delay_seconds: auto_lock_delay_seconds}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Returns a specified [lock](https://docs.seam.co/low-level-apis/smart-locks).
      # @param device_id [String, nil] ID of the lock that you want to get.
      # @param name [String, nil] Name of the lock that you want to get.
      # @return [Seam::Resources::Device] OK
      # @deprecated Use `/devices/get` instead.
      def get(device_id: nil, name: nil)
        if device_id.nil? && name.nil?
          raise TypeError, "At least one parameter is required for /locks/get"
        end

        res = @client.get("/locks/get", {device_id: device_id, name: name}.compact)

        Seam::Resources::Device.load_from_response(res.body["device"])
      end

      # Returns a list of all [locks](https://docs.seam.co/low-level-apis/smart-locks).
      # @param connect_webview_id [String, nil] ID of the Connect Webview for which you want to list devices.
      # @param connected_account_id [String, nil] ID of the connected account for which you want to list devices.
      # @param customer_key [String, nil] Customer key for which you want to list devices.
      # @param device_type [String, nil] Device type of the locks that you want to list.
      # @param device_types [Array<String>, nil] Device types of the locks that you want to list.
      # @param manufacturer [String, nil] Manufacturer of the locks that you want to list.
      # @return [Seam::Resources::Device] OK
      def list(connect_webview_id: nil, connected_account_id: nil, customer_key: nil, device_type: nil, device_types: nil, manufacturer: nil)
        res = @client.post("/locks/list", {connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, customer_key: customer_key, device_type: device_type, device_types: device_types, manufacturer: manufacturer}.compact)

        Seam::Resources::Device.load_from_response(res.body["devices"])
      end

      # Locks a [lock](https://docs.seam.co/low-level-apis/smart-locks). See also [Locking and Unlocking Smart Locks](https://docs.seam.co/low-level-apis/smart-locks/lock-and-unlock).
      # @param device_id [String] ID of the lock that you want to lock.
      # @return [Seam::Resources::ActionAttempt] OK
      def lock_door(device_id:, wait_for_action_attempt: nil)
        res = @client.post("/locks/lock_door", {device_id: device_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Unlocks a [lock](https://docs.seam.co/low-level-apis/smart-locks). See also [Locking and Unlocking Smart Locks](https://docs.seam.co/low-level-apis/smart-locks/lock-and-unlock).
      # @param device_id [String] ID of the lock that you want to unlock.
      # @return [Seam::Resources::ActionAttempt] OK
      def unlock_door(device_id:, wait_for_action_attempt: nil)
        res = @client.post("/locks/unlock_door", {device_id: device_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end
    end
  end
end
