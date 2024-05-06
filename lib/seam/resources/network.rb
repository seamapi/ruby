# frozen_string_literal: true

module Seam
  class Network < BaseResource
    attr_accessor :display_name, :network_id, :workspace_id

    date_accessor :created_at
  end
end
