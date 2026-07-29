# frozen_string_literal: true

module Seam
  module Clients
    class ConnectedAccountsSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Simulates a connected account becoming disconnected from Seam. Only applicable for [sandbox workspaces](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces).
      # @param connected_account_id ID of the connected account you want to simulate as disconnected.
      # @return [nil] OK
      def disconnect(connected_account_id:)
        @client.post("/connected_accounts/simulate/disconnect", {connected_account_id: connected_account_id}.compact)

        nil
      end
    end
  end
end
