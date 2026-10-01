# frozen_string_literal: true

module Seam
  module Clients
    class Media
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Returns a specified piece of media, such as a video clip or thumbnail image captured for a camera event, with a short-lived URL from which you can download it. Camera events list their media in `media_ids`. This endpoint is in beta.
      # @param media_id [String] ID of the media that you want to get.
      # @param format [String, nil] Response format. `json` returns the media object. `redirect` responds with a `302` redirect to the media's download URL, so you can use this endpoint directly as the source of an image or video.
      # @return [Seam::Resources::Media] OK
      def get(media_id:, format: nil)
        res = @client.get("/media/get", {media_id: media_id, format: format}.compact)

        Seam::Resources::Media.load_from_response(res.body["media"])
      end
    end
  end
end
