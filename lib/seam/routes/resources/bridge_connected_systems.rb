# frozen_string_literal: true

module Seam
  module Resources
    class BridgeConnectedSystems < BaseResource
      attr_accessor :acs_system_display_name, :acs_system_id, :bridge_id, :connected_account_id, :workspace_display_name, :workspace_id

      date_accessor :bridge_created_at, :connected_account_created_at
    end
  end
end
