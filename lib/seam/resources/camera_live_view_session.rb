# frozen_string_literal: true

module Seam
  module Resources
    # Represents a short-lived live view session for a single camera. Use the session ID and token to start a WebRTC stream and to stop the session.
    class CameraLiveViewSession < BaseResource
      # ID of the camera live view session.
      # @return [String]
      attr_accessor :camera_live_view_session_id
      # ID of the camera.
      # @return [String]
      attr_accessor :device_id
      # Token that authorizes the offer and stop requests for this session.
      # @return [String]
      attr_accessor :token

      # Date and time at which the live view session expires.
      # @return [Time]
      date_accessor :expires_at
    end
  end
end
