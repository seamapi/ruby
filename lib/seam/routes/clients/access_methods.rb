# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class AccessMethods
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def unmanaged
        @unmanaged ||= Seam::Clients::AccessMethodsUnmanaged.new(client: @client, defaults: @defaults)
      end

      def delete(access_method_id: nil, access_grant_id: nil, reservation_key: nil)
        @client.post("/access_methods/delete", {access_method_id: access_method_id, access_grant_id: access_grant_id, reservation_key: reservation_key}.compact)

        nil
      end

      def encode(access_method_id:, acs_encoder_id:, wait_for_action_attempt: nil)
        res = @client.post("/access_methods/encode", {access_method_id: access_method_id, acs_encoder_id: acs_encoder_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      def get(access_method_id:)
        res = @client.post("/access_methods/get", {access_method_id: access_method_id}.compact)

        Seam::Resources::AccessMethod.load_from_response(res.body["access_method"])
      end

      def get_related(access_method_ids:, exclude: nil, include: nil)
        res = @client.post("/access_methods/get_related", {access_method_ids: access_method_ids, exclude: exclude, include: include}.compact)

        Seam::Resources::Batch.load_from_response(res.body["batch"])
      end

      def list(access_code_id: nil, access_grant_id: nil, access_grant_key: nil, acs_entrance_id: nil, device_id: nil, space_id: nil)
        res = @client.post("/access_methods/list", {access_code_id: access_code_id, access_grant_id: access_grant_id, access_grant_key: access_grant_key, acs_entrance_id: acs_entrance_id, device_id: device_id, space_id: space_id}.compact)

        Seam::Resources::AccessMethod.load_from_response(res.body["access_methods"])
      end
    end
  end
end
