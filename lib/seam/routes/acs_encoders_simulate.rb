# frozen_string_literal: true

module Seam
  module Clients
    class AcsEncodersSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def next_credential_encode_will_fail(acs_encoder_id:, error_code: nil, acs_credential_id: nil)
        @client.post("/acs/encoders/simulate/next_credential_encode_will_fail", {acs_encoder_id: acs_encoder_id, error_code: error_code, acs_credential_id: acs_credential_id}.compact)

        nil
      end

      def next_credential_encode_will_succeed(acs_encoder_id:, scenario: nil)
        @client.post("/acs/encoders/simulate/next_credential_encode_will_succeed", {acs_encoder_id: acs_encoder_id, scenario: scenario}.compact)

        nil
      end

      def next_credential_scan_will_fail(acs_encoder_id:, error_code: nil, acs_credential_id_on_seam: nil)
        @client.post("/acs/encoders/simulate/next_credential_scan_will_fail", {acs_encoder_id: acs_encoder_id, error_code: error_code, acs_credential_id_on_seam: acs_credential_id_on_seam}.compact)

        nil
      end

      def next_credential_scan_will_succeed(acs_encoder_id:, acs_credential_id_on_seam: nil, scenario: nil)
        @client.post("/acs/encoders/simulate/next_credential_scan_will_succeed", {acs_encoder_id: acs_encoder_id, acs_credential_id_on_seam: acs_credential_id_on_seam, scenario: scenario}.compact)

        nil
      end
    end
  end
end
