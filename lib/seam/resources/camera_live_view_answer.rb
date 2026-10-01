# frozen_string_literal: true

module Seam
  module Resources
    # Represents the WebRTC SDP answer that starts streaming video from a camera for a live view session.
    class CameraLiveViewAnswer < BaseResource
      # WebRTC SDP answer for the offer, limited to 64 KiB of UTF-8 data.
      # @return [String]
      attr_accessor :sdp_answer
    end
  end
end
