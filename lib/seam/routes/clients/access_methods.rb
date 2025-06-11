# frozen_string_literal: true

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
