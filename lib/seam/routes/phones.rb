# frozen_string_literal: true

module Seam
  module Clients
    class Phones
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def simulate
        @simulate ||= Seam::Clients::PhonesSimulate.new(client: @client, defaults: @defaults)
      end

      def deactivate(device_id:)
        @client.post("/phones/deactivate", {device_id: device_id}.compact)

        nil
      end

      def get(device_id:)
        res = @client.post("/phones/get", {device_id: device_id}.compact)

        Seam::Resources::Phone.load_from_response(res.body["phone"])
      end

      def list(acs_credential_id: nil, owner_user_identity_id: nil)
        res = @client.post("/phones/list", {acs_credential_id: acs_credential_id, owner_user_identity_id: owner_user_identity_id}.compact)

        Seam::Resources::Phone.load_from_response(res.body["phones"])
      end
    end
  end
end
