# frozen_string_literal: true

module Seam
  module Http
    module Auth
      TOKEN_PREFIX = "seam_"

      ACCESS_TOKEN_PREFIX = "seam_at"

      JWT_PREFIX = "ey"

      CLIENT_SESSION_TOKEN_PREFIX = "seam_cst"

      PUBLISHABLE_KEY_TOKEN_PREFIX = "seam_pk"

      def self.access_token?(token)
        token.start_with?(ACCESS_TOKEN_PREFIX)
      end

      def self.jwt?(token)
        token.start_with?(JWT_PREFIX)
      end

      def self.seam_token?(token)
        token.start_with?(TOKEN_PREFIX)
      end

      def self.api_key?(token)
        !client_session_token?(token) &&
          !jwt?(token) &&
          !access_token?(token) &&
          !publishable_key?(token) &&
          seam_token?(token)
      end

      def self.client_session_token?(token)
        token.start_with?(CLIENT_SESSION_TOKEN_PREFIX)
      end

      def self.publishable_key?(token)
        token.start_with?(PUBLISHABLE_KEY_TOKEN_PREFIX)
      end

      def self.console_session_token?(token)
        jwt?(token)
      end

      def self.personal_access_token?(token)
        access_token?(token)
      end
    end
  end
end
