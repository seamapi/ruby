# frozen_string_literal: true

module Seam
  module Clients
    class AcsEncodersSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Simulates that the next attempt to encode a [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) using the specified [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners) will fail. You can only perform this action within a [sandbox workspace](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces).
      # @param acs_encoder_id [String] ID of the `acs_encoder` that will be used in the next request to encode the `acs_credential`.
      # @param error_code [String, nil] Code of the error to simulate.
      # @param acs_credential_id [String, nil] ID of the `acs_credential` that will fail to be encoded onto a card in the next request.
      # @return [nil] OK
      def next_credential_encode_will_fail(acs_encoder_id:, error_code: nil, acs_credential_id: nil)
        @client.post("/acs/encoders/simulate/next_credential_encode_will_fail", {acs_encoder_id: acs_encoder_id, error_code: error_code, acs_credential_id: acs_credential_id}.compact)

        nil
      end

      # Simulates that the next attempt to encode a [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) using the specified [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners) will succeed. You can only perform this action within a [sandbox workspace](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces).
      # @param acs_encoder_id [String] ID of the `acs_encoder` that will be used in the next request to encode the `acs_credential`.
      # @param scenario [String, nil] Scenario to simulate.
      # @return [nil] OK
      def next_credential_encode_will_succeed(acs_encoder_id:, scenario: nil)
        @client.post("/acs/encoders/simulate/next_credential_encode_will_succeed", {acs_encoder_id: acs_encoder_id, scenario: scenario}.compact)

        nil
      end

      # Simulates that the next attempt to scan a [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) using the specified [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners) will fail. You can only perform this action within a [sandbox workspace](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces).
      # @param acs_encoder_id [String] ID of the `acs_encoder` that will fail to scan the `acs_credential` in the next request.
      # @param error_code [String, nil]
      # @param acs_credential_id_on_seam [String, nil]
      # @return [nil] OK
      def next_credential_scan_will_fail(acs_encoder_id:, error_code: nil, acs_credential_id_on_seam: nil)
        @client.post("/acs/encoders/simulate/next_credential_scan_will_fail", {acs_encoder_id: acs_encoder_id, error_code: error_code, acs_credential_id_on_seam: acs_credential_id_on_seam}.compact)

        nil
      end

      # Simulates that the next attempt to scan a [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) using the specified [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners) will succeed. You can only perform this action within a [sandbox workspace](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces).
      # @param acs_encoder_id [String] ID of the `acs_encoder` that will be used in the next request to scan the `acs_credential`.
      # @param acs_credential_id_on_seam [String, nil] ID of the Seam `acs_credential` that matches the `acs_credential` on the encoder in this simulation.
      # @param scenario [String, nil] Scenario to simulate.
      # @return [nil] OK
      def next_credential_scan_will_succeed(acs_encoder_id:, acs_credential_id_on_seam: nil, scenario: nil)
        @client.post("/acs/encoders/simulate/next_credential_scan_will_succeed", {acs_encoder_id: acs_encoder_id, acs_credential_id_on_seam: acs_credential_id_on_seam, scenario: scenario}.compact)

        nil
      end
    end
  end
end
