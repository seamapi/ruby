# frozen_string_literal: true

module Seam
  module Resources
    class BridgeClientSession < BaseResource
      attr_accessor :bridge_client_machine_identifier_key, :bridge_client_name, :bridge_client_session_id, :bridge_client_session_token, :bridge_client_time_zone, :pairing_code, :tailscale_auth_key, :tailscale_hostname, :telemetry_token, :telemetry_url

      date_accessor :created_at, :pairing_code_expires_at, :telemetry_token_expires_at

      include Seam::Resources::ResourceErrorsSupport
    end
  end
end
