# frozen_string_literal: true

module Seam
  module Clients
    class Events
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Returns a specified event. This endpoint returns the same event that would be sent to a [webhook](https://docs.seam.co/developer-tools/webhooks), but it enables you to retrieve an event that already took place.
      # @param event_id [String, nil] Unique identifier for the event that you want to get.
      # @param device_id [String, nil] Unique identifier for the device that triggered the event that you want to get.
      # @param event_type [String, nil] Type of the event that you want to get.
      # @return [Seam::Resources::SeamEvent] OK
      def get(event_id: nil, device_id: nil, event_type: nil)
        if event_id.nil? && device_id.nil? && event_type.nil?
          raise TypeError, "At least one parameter is required for /events/get"
        end

        res = @client.post("/events/get", {event_id: event_id, device_id: device_id, event_type: event_type}.compact)

        Seam::Resources::SeamEvent.load_from_response(res.body["event"])
      end

      # Returns a list of all events. This endpoint returns the same events that would be sent to a [webhook](https://docs.seam.co/developer-tools/webhooks), but it enables you to filter or see events that already took place.
      # @param access_code_id [String, nil] ID of the access code for which you want to list events.
      # @param access_code_ids [Array<String>, nil] IDs of the access codes for which you want to list events.
      # @param access_grant_id [String, nil] ID of the access grant for which you want to list events.
      # @param access_grant_ids [Array<String>, nil] IDs of the access grants for which you want to list events.
      # @param access_method_id [String, nil] ID of the access method for which you want to list events.
      # @param access_method_ids [Array<String>, nil] IDs of the access methods for which you want to list events.
      # @param acs_access_group_id [String, nil] ID of the ACS access group for which you want to list events.
      # @param acs_credential_id [String, nil] ID of the ACS credential for which you want to list events.
      # @param acs_encoder_id [String, nil] ID of the ACS encoder for which you want to list events.
      # @param acs_entrance_id [String, nil] ID of the ACS entrance for which you want to list events.
      # @param acs_system_id [String, nil] ID of the access system for which you want to list events.
      # @param acs_system_ids [Array<String>, nil] IDs of the access systems for which you want to list events.
      # @param acs_user_id [String, nil] ID of the ACS user for which you want to list events.
      # @param between [Array<Time>, nil] Lower and upper timestamps to define an exclusive interval containing the events that you want to list. You must include `since` or `between`.
      # @param connect_webview_id [String, nil] ID of the Connect Webview for which you want to list events.
      # @param connected_account_id [String, nil] ID of the connected account for which you want to list events.
      # @param customer_key [String, nil] Customer key for which you want to list events.
      # @param device_id [String, nil] ID of the device for which you want to list events.
      # @param device_ids [Array<String>, nil] IDs of the devices for which you want to list events.
      # @param event_ids [Array<String>, nil] IDs of the events that you want to list.
      # @param event_type [String, nil] Type of the events that you want to list.
      # @param event_types [Array<String>, nil] Types of the events that you want to list.
      # @param limit [Float, nil] Numerical limit on the number of events to return.
      # @param since [String, nil] Timestamp to indicate the beginning generation time for the events that you want to list. You must include `since` or `between`.
      # @param space_id [String, nil] ID of the space for which you want to list events.
      # @param space_ids [Array<String>, nil] IDs of the spaces for which you want to list events.
      # @param unstable_offset [Float, nil] Offset for the events that you want to list.
      # @param user_identity_id [String, nil] ID of the user identity for which you want to list events.
      # @return [Seam::Resources::SeamEvent] OK
      def list(access_code_id: nil, access_code_ids: nil, access_grant_id: nil, access_grant_ids: nil, access_method_id: nil, access_method_ids: nil, acs_access_group_id: nil, acs_credential_id: nil, acs_encoder_id: nil, acs_entrance_id: nil, acs_system_id: nil, acs_system_ids: nil, acs_user_id: nil, between: nil, connect_webview_id: nil, connected_account_id: nil, customer_key: nil, device_id: nil, device_ids: nil, event_ids: nil, event_type: nil, event_types: nil, limit: nil, since: nil, space_id: nil, space_ids: nil, unstable_offset: nil, user_identity_id: nil)
        if access_code_id.nil? && access_code_ids.nil? && access_grant_id.nil? && access_grant_ids.nil? && access_method_id.nil? && access_method_ids.nil? && acs_access_group_id.nil? && acs_credential_id.nil? && acs_encoder_id.nil? && acs_entrance_id.nil? && acs_system_id.nil? && acs_system_ids.nil? && acs_user_id.nil? && between.nil? && connect_webview_id.nil? && connected_account_id.nil? && customer_key.nil? && device_id.nil? && device_ids.nil? && event_ids.nil? && event_type.nil? && event_types.nil? && limit.nil? && since.nil? && space_id.nil? && space_ids.nil? && unstable_offset.nil? && user_identity_id.nil?
          raise TypeError, "At least one parameter is required for /events/list"
        end

        res = @client.post("/events/list", {access_code_id: access_code_id, access_code_ids: access_code_ids, access_grant_id: access_grant_id, access_grant_ids: access_grant_ids, access_method_id: access_method_id, access_method_ids: access_method_ids, acs_access_group_id: acs_access_group_id, acs_credential_id: acs_credential_id, acs_encoder_id: acs_encoder_id, acs_entrance_id: acs_entrance_id, acs_system_id: acs_system_id, acs_system_ids: acs_system_ids, acs_user_id: acs_user_id, between: between, connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, customer_key: customer_key, device_id: device_id, device_ids: device_ids, event_ids: event_ids, event_type: event_type, event_types: event_types, limit: limit, since: since, space_id: space_id, space_ids: space_ids, unstable_offset: unstable_offset, user_identity_id: user_identity_id}.compact)

        Seam::Resources::SeamEvent.load_from_response(res.body["events"])
      end
    end
  end
end
