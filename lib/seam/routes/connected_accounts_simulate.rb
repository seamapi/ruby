# frozen_string_literal: true

module Seam
  module Clients
    class ConnectedAccountsSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def disconnect(connected_account_id:)
        @client.post("/connected_accounts/simulate/disconnect", {connected_account_id: connected_account_id}.compact)

        nil
      end
    end
  end
end
