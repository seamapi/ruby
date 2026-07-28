# frozen_string_literal: true

module Seam
  module Clients
    class DevicesSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Simulates connecting a device to Seam. Only applicable for [sandbox devices](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces). See also [Testing Your App Against Device Disconnection and Removal](https://docs.seam.co/core-concepts/devices/testing-your-app-against-device-disconnection-and-removal).
      # @param device_id ID of the device that you want to simulate connecting to Seam.
      # @return [nil] OK
      def connect(device_id:)
        @client.post("/devices/simulate/connect", {device_id: device_id}.compact)

        nil
      end

      # Simulates bringing the Wi‑Fi hub (bridge) back online for a device.
      # Only applicable for sandbox workspaces and currently
      # implemented for August and TTLock locks.
      # This will clear the `hub_disconnected` error on the device.
      # @param device_id ID of the device whose hub you want to reconnect.
      # @return [nil] OK
      def connect_to_hub(device_id:)
        @client.post("/devices/simulate/connect_to_hub", {device_id: device_id}.compact)

        nil
      end

      # Simulates disconnecting a device from Seam. Only applicable for [sandbox devices](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces). See also [Testing Your App Against Device Disconnection and Removal](https://docs.seam.co/core-concepts/devices/testing-your-app-against-device-disconnection-and-removal).
      # @param device_id ID of the device that you want to simulate disconnecting from Seam.
      # @return [nil] OK
      def disconnect(device_id:)
        @client.post("/devices/simulate/disconnect", {device_id: device_id}.compact)

        nil
      end

      # Simulates taking the Wi‑Fi hub (bridge) offline for a device.
      # Only applicable for sandbox workspaces and currently
      # implemented for August, TTLock, and IglooHome devices.
      # This will set the `hub_disconnected` error on the device, or mark the
      # IglooHome bridge offline in sandbox.
      # @param device_id ID of the device whose hub you want to disconnect.
      # @return [nil] OK
      def disconnect_from_hub(device_id:)
        @client.post("/devices/simulate/disconnect_from_hub", {device_id: device_id}.compact)

        nil
      end

      # Toggle the simulated Nuki Smart Hosting subscription for a device (sandbox only).
      # Send `is_expired: true` to simulate an expired subscription, or `false` to simulate an active subscription.
      # The actual device error is created/cleared by the poller after this state change.
      # @param device_id
      # @param is_expired
      # @return [nil] OK
      def paid_subscription(device_id:, is_expired:)
        @client.post("/devices/simulate/paid_subscription", {device_id: device_id, is_expired: is_expired}.compact)

        nil
      end

      # Simulates removing a device from Seam. Only applicable for [sandbox devices](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces). See also [Testing Your App Against Device Disconnection and Removal](https://docs.seam.co/core-concepts/devices/testing-your-app-against-device-disconnection-and-removal).
      # @param device_id ID of the device that you want to simulate removing from Seam.
      # @return [nil] OK
      def remove(device_id:)
        @client.post("/devices/simulate/remove", {device_id: device_id}.compact)

        nil
      end
    end
  end
end
