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

      # Deactivates a phone, which is useful, for example, if a user has lost their phone. For more information, see [App User Lost Phone Process](https://docs.seam.co/capability-guides/mobile-access/managing-phones-for-a-user-identity#app-user-lost-phone-process).
      # @param device_id Device ID of the phone that you want to deactivate.
      # @return [nil] OK
      def deactivate(device_id:)
        @client.post("/phones/deactivate", {device_id: device_id}.compact)

        nil
      end

      # Returns a specified [phone](https://docs.seam.co/capability-guides/mobile-access/managing-phones-for-a-user-identity).
      # @param device_id Device ID of the phone that you want to get.
      # @return [Seam::Resources::Phone] OK
      def get(device_id:)
        res = @client.post("/phones/get", {device_id: device_id}.compact)

        Seam::Resources::Phone.load_from_response(res.body["phone"])
      end

      # Returns a list of all [phones](https://docs.seam.co/capability-guides/mobile-access/managing-phones-for-a-user-identity). To filter the list of returned phones by a specific owner user identity or credential, include the `owner_user_identity_id` or `acs_credential_id`, respectively, in the request body.
      # @param acs_credential_id ID of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) by which you want to filter the list of returned phones.
      # @param owner_user_identity_id ID of the user identity that represents the owner by which you want to filter the list of returned phones.
      # @return [Seam::Resources::Phone] OK
      def list(acs_credential_id: nil, owner_user_identity_id: nil)
        res = @client.post("/phones/list", {acs_credential_id: acs_credential_id, owner_user_identity_id: owner_user_identity_id}.compact)

        Seam::Resources::Phone.load_from_response(res.body["phones"])
      end
    end
  end
end
