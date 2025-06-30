# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class AccessMethods
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def delete(access_method_id:)
        @client.post("/access_methods/delete", {access_method_id: access_method_id}.compact)

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

      def list(access_grant_id:)
        res = @client.post("/access_methods/list", {access_grant_id: access_grant_id}.compact)

        Seam::Resources::AccessMethod.load_from_response(res.body["access_methods"])
      end
    end
  end
end
