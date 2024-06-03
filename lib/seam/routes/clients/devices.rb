# frozen_string_literal: true

module Seam
  module Clients
    class Devices < BaseClient
      def simulate
        @simulate ||= Seam::Clients::DevicesSimulate.new(self)
      end

      def unmanaged
        @unmanaged ||= Seam::Clients::DevicesUnmanaged.new(self)
      end

      def delete(device_id:)
        request_seam(
          :post,
          "/devices/delete",
          body: {device_id: device_id}.compact
        )

        nil
      end

      def get(device_id: nil, name: nil)
        request_seam_object(
          :post,
          "/devices/get",
          Seam::Device,
          "device",
          body: {device_id: device_id, name: name}.compact
        )
      end

      def list(connect_webview_id: nil, connected_account_id: nil, connected_account_ids: nil, created_before: nil, custom_metadata_has: nil, device_ids: nil, device_types: nil, exclude_if: nil, include_if: nil, limit: nil, manufacturer: nil, user_identifier_key: nil)
        request_seam_object(
          :post,
          "/devices/list",
          Seam::Device,
          "devices",
          body: {connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, connected_account_ids: connected_account_ids, created_before: created_before, custom_metadata_has: custom_metadata_has, device_ids: device_ids, device_types: device_types, exclude_if: exclude_if, include_if: include_if, limit: limit, manufacturer: manufacturer, user_identifier_key: user_identifier_key}.compact
        )
      end

      def list_device_providers(provider_category: nil)
        request_seam_object(
          :post,
          "/devices/list_device_providers",
          Seam::DeviceProvider,
          "device_providers",
          body: {provider_category: provider_category}.compact
        )
      end

      def update(device_id:, custom_metadata: nil, is_managed: nil, name: nil, properties: nil)
        request_seam(
          :post,
          "/devices/update",
          body: {device_id: device_id, custom_metadata: custom_metadata, is_managed: is_managed, name: name, properties: properties}.compact
        )

        nil
      end
    end
  end
end
