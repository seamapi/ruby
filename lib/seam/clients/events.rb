# frozen_string_literal: true

module Seam
  module Clients
    class Events < BaseClient
      def get(event_id: nil, event_type: nil, device_id: nil)
        request_seam_object(
          :post,
          "/events/get",
          Seam::Event,
          "event",
          body: {event_id: event_id, event_type: event_type, device_id: device_id}.compact
        )
      end

      def list(since: str, event_type: nil, event_types: nil, device_id: nil, device_ids: nil)
        request_seam_object(
          :post,
          "/events/list",
          Seam::Event,
          "events",
          body: {event_type: event_type, event_types: event_types, device_id: device_id,
                 device_ids: device_ids, since: since}.compact
        )
      end
    end
  end
end
