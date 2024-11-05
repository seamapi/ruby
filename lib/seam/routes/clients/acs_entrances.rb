# frozen_string_literal: true

module Seam
  module Clients
    class AcsEntrances
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(acs_entrance_id:)
        res = @client.post("/acs/entrances/get", {acs_entrance_id: acs_entrance_id}.compact)

        Seam::Resources::AcsEntrance.load_from_response(res.body["acs_entrance"])
      end

      def grant_access(acs_entrance_id:, acs_user_id:)
        @client.post("/acs/entrances/grant_access", {acs_entrance_id: acs_entrance_id, acs_user_id: acs_user_id}.compact)

        nil
      end

      def list(acs_credential_id: nil, acs_system_id: nil)
        res = @client.post("/acs/entrances/list", {acs_credential_id: acs_credential_id, acs_system_id: acs_system_id}.compact)

        Seam::Resources::AcsEntrance.load_from_response(res.body["acs_entrances"])
      end

      def list_credentials_with_access(acs_entrance_id:, include_if: nil)
        res = @client.post("/acs/entrances/list_credentials_with_access", {acs_entrance_id: acs_entrance_id, include_if: include_if}.compact)

        Seam::Resources::AcsCredential.load_from_response(res.body["acs_credentials"])
      end
    end
  end
end
