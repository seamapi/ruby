# frozen_string_literal: true

module Seam
  module Resources
    class AcsEntrance < BaseResource
      attr_accessor :acs_entrance_id, :acs_system_id, :display_name, :dormakaba_community_metadata, :latch_metadata, :salto_ks_metadata, :visionline_metadata

      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
    end
  end
end
