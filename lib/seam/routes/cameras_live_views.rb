# frozen_string_literal: true

module Seam
  module Clients
    class CamerasLiveViews
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Creates a short-lived live view session for a single camera. Pass the returned session ID and token to `/cameras/live_views/offer` to start a WebRTC stream, and to `/cameras/live_views/stop` to end the session.
      #
      # Camera live view is in beta. To enable it for your workspace, contact Seam support. To check whether a camera supports live view, use `device.can_stream_live_video`.
      # @param device_id [String] ID of the camera to view.
      # @param duration_seconds [Integer, nil] Number of seconds for which the live view session is valid, up to 600.
      # @param include_audio [Boolean, nil] Indicates whether to include the camera's audio.
      # @return [Seam::Resources::CameraLiveViewSession] OK
      def create(device_id:, duration_seconds: nil, include_audio: nil)
        res = @client.post("/cameras/live_views/create", {device_id: device_id, duration_seconds: duration_seconds, include_audio: include_audio}.compact)

        Seam::Resources::CameraLiveViewSession.load_from_response(res.body["camera_live_view_session"])
      end

      # Exchanges a WebRTC SDP offer for an SDP answer that starts streaming video from the camera, for a live view session that you created using `/cameras/live_views/create`.
      #
      # Camera live view is in beta. To enable it for your workspace, contact Seam support.
      # @param camera_live_view_session_id [String] ID of the camera live view session.
      # @param sdp_offer [String] WebRTC SDP offer from the viewer, limited to 64 KiB of UTF-8 data.
      # @param token [String] Token returned when the camera live view session was created.
      # @return [Seam::Resources::CameraLiveViewAnswer] OK
      def offer(camera_live_view_session_id:, sdp_offer:, token:)
        res = @client.post("/cameras/live_views/offer", {camera_live_view_session_id: camera_live_view_session_id, sdp_offer: sdp_offer, token: token}.compact)

        Seam::Resources::CameraLiveViewAnswer.load_from_response(res.body["camera_live_view_answer"])
      end

      # Stops a camera live view session that the current client session owns.
      #
      # Camera live view is in beta. To enable it for your workspace, contact Seam support.
      # @param camera_live_view_session_id [String] ID of the camera live view session.
      # @param token [String] Token returned when the camera live view session was created.
      # @return [nil] OK
      def stop(camera_live_view_session_id:, token:)
        @client.post("/cameras/live_views/stop", {camera_live_view_session_id: camera_live_view_session_id, token: token}.compact)

        nil
      end
    end
  end
end
