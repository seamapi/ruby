# frozen_string_literal: true

module Seam
  module Resources
    class AcsEntrance < BaseResource
      attr_accessor :acs_entrance_id, :acs_system_id, :assa_abloy_vostio_metadata, :can_unlock_with_card, :can_unlock_with_code, :can_unlock_with_mobile_key, :connected_account_id, :display_name, :dormakaba_ambiance_metadata, :dormakaba_community_metadata, :hotek_metadata, :latch_metadata, :salto_ks_metadata, :salto_space_metadata, :space_ids, :visionline_metadata

      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
    end
  end
end
