# frozen_string_literal: true

module Seam
  module Resources
    # Represents a piece of media, such as a video clip or a thumbnail image, that a device captured for an event. Media is in beta.
    class Media < BaseResource
      # MIME type of the media, such as `video/mp4` or `image/jpeg`.
      # @return [String, nil]
      attr_accessor :content_type
      # ID of the device that captured the media.
      # @return [String, nil]
      attr_accessor :device_id
      # ID of the event that the media belongs to.
      # @return [String, nil]
      attr_accessor :event_id
      # ID of the media.
      # @return [String]
      attr_accessor :media_id
      # Type of the media: a video clip or a still image.
      # @return [String]
      # Known values:
      # - `video`
      # - `image`
      attr_accessor :media_type
      # Status of the media. `pending` means that Seam is still retrieving the media. `available` means that `url` can be used to download it. `unavailable` means that no media exists for the event, and `failed` means that Seam could not retrieve it.
      # @return [String]
      # Known values:
      # - `pending`
      # - `available`
      # - `unavailable`
      # - `failed`
      attr_accessor :status
      # Short-lived URL from which you can download the media. Null unless `status` is `available`. The URL expires after about five minutes. Call `/media/get` again for a new URL.
      # @return [String, nil]
      attr_accessor :url
      # Video codec used to encode the media. Only present for video media. `hevc` (H.265) playback support varies by browser and device, so check compatibility before assuming a clip plays inline.
      # @return [String, nil]
      # Known values:
      # - `h264`
      # - `hevc`
      attr_accessor :video_codec
      # ID of the workspace that contains the media.
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the media was created.
      # @return [Time]
      date_accessor :created_at

      # Date and time at which the media stops being available. Null when Seam does not know when the media expires.
      # @return [Time, nil]
      date_accessor :expires_at
    end
  end
end
