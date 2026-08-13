# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class AcsEncoders
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def simulate
        @simulate ||= Seam::Clients::AcsEncodersSimulate.new(client: @client, defaults: @defaults)
      end

      # Encodes an existing [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) onto a plastic card placed on the specified [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners). Either provide an `acs_credential_id` or an `access_method_id`
      # @param acs_encoder_id [String] ID of the `acs_encoder` to use to encode the `acs_credential`.
      # @param access_method_id [String, nil] ID of the `access_method` to encode onto a card.
      # @param acs_credential_id [String, nil] ID of the `acs_credential` to encode onto a card.
      # @return [Seam::Resources::ActionAttempt] OK
      def encode_credential(acs_encoder_id:, access_method_id: nil, acs_credential_id: nil, wait_for_action_attempt: nil)
        res = @client.post("/acs/encoders/encode_credential", {acs_encoder_id: acs_encoder_id, access_method_id: access_method_id, acs_credential_id: acs_credential_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Returns a specified [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners).
      # @param acs_encoder_id [String] ID of the encoder that you want to get.
      # @return [Seam::Resources::AcsEncoder] OK
      def get(acs_encoder_id:)
        res = @client.get("/acs/encoders/get", {acs_encoder_id: acs_encoder_id}.compact)

        Seam::Resources::AcsEncoder.load_from_response(res.body["acs_encoder"])
      end

      # Returns a list of all [encoders](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners).
      # @param acs_system_id [String, nil] ID of the access system for which you want to retrieve all encoders.
      # @param acs_system_ids [Array<String>, nil] IDs of the access systems for which you want to retrieve all encoders.
      # @param acs_encoder_ids [Array<String>, nil] IDs of the encoders that you want to retrieve.
      # @param limit [Float, nil] Number of encoders to return.
      # @param page_cursor [String, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @return [Seam::Resources::AcsEncoder] OK
      def list(acs_system_id: nil, acs_system_ids: nil, acs_encoder_ids: nil, limit: nil, page_cursor: nil)
        res = @client.post("/acs/encoders/list", {acs_system_id: acs_system_id, acs_system_ids: acs_system_ids, acs_encoder_ids: acs_encoder_ids, limit: limit, page_cursor: page_cursor}.compact)

        Seam::Resources::AcsEncoder.load_from_response(res.body["acs_encoders"])
      end

      # Scans an encoded [acs_credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) from a plastic card placed on the specified [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners).
      # @param acs_encoder_id [String] ID of the encoder to use for the scan.
      # @param salto_ks_metadata [Hash, nil] Salto KS-specific metadata for the scan action.
      # @return [Seam::Resources::ActionAttempt] OK
      def scan_credential(acs_encoder_id:, salto_ks_metadata: nil, wait_for_action_attempt: nil)
        res = @client.post("/acs/encoders/scan_credential", {acs_encoder_id: acs_encoder_id, salto_ks_metadata: salto_ks_metadata}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Scans a physical card placed on the specified [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners) and assigns the scanned credential to an ACS user. Provide either an `acs_user_id` or a `user_identity_id`.
      # @param acs_encoder_id [String] ID of the `acs_encoder` to use to scan the credential.
      # @param acs_user_id [String, nil] ID of the `acs_user` to assign the scanned credential to.
      # @param salto_ks_metadata [Hash, nil] Salto KS-specific metadata for the scan action.
      # @param user_identity_id [String, nil] ID of the `user_identity` to assign the scanned credential to. If the ACS system contains an ACS user linked to this user identity, it is used. Otherwise, one is created.
      # @return [Seam::Resources::ActionAttempt] OK
      def scan_to_assign_credential(acs_encoder_id:, acs_user_id: nil, salto_ks_metadata: nil, user_identity_id: nil, wait_for_action_attempt: nil)
        res = @client.post("/acs/encoders/scan_to_assign_credential", {acs_encoder_id: acs_encoder_id, acs_user_id: acs_user_id, salto_ks_metadata: salto_ks_metadata, user_identity_id: user_identity_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end
    end
  end
end
