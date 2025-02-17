# frozen_string_literal: true

module Seam
  module Clients
    class Events
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(device_id: nil, event_id: nil, event_type: nil)
        res = @client.post("/events/get", {device_id: device_id, event_id: event_id, event_type: event_type}.compact)

        Seam::Resources::SeamEvent.load_from_response(res.body["event"])
      end

      def list(access_code_id: nil, access_code_ids: nil, acs_system_id: nil, acs_system_ids: nil, between: nil, connect_webview_id: nil, connected_account_id: nil, device_id: nil, device_ids: nil, event_ids: nil, event_type: nil, event_types: nil, limit: nil, since: nil, unstable_offset: nil)
        res = @client.post("/events/list", {access_code_id: access_code_id, access_code_ids: access_code_ids, acs_system_id: acs_system_id, acs_system_ids: acs_system_ids, between: between, connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, device_id: device_id, device_ids: device_ids, event_ids: event_ids, event_type: event_type, event_types: event_types, limit: limit, since: since, unstable_offset: unstable_offset}.compact)

        Seam::Resources::SeamEvent.load_from_response(res.body["events"])
      end
    end
  end
end
