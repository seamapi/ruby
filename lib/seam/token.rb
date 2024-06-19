# frozen_string_literal: true

module Seam
  TOKEN_PREFIX = "seam_"
  ACCESS_TOKEN_PREFIX = "seam_at"
  JWT_PREFIX = "ey"
  CLIENT_SESSION_TOKEN_PREFIX = "seam_cst"
  PUBLISHABLE_KEY_TOKEN_PREFIX = "seam_pk"

  def is_access_token(token)
    token.start_with?(ACCESS_TOKEN_PREFIX)
  end

  def is_jwt(token)
    token.start_with?(JWT_PREFIX)
  end

  def is_seam_token(token)
    token.start_with?(TOKEN_PREFIX)
  end

  def is_api_key(token)
    !is_client_session_token(token) &&
      !is_jwt(token) &&
      !is_access_token(token) &&
      !is_publishable_key(token) &&
      is_seam_token(token)
  end

  def is_client_session_token(token)
    token.start_with?(CLIENT_SESSION_TOKEN_PREFIX)
  end

  def is_publishable_key(token)
    token.start_with?(PUBLISHABLE_KEY_TOKEN_PREFIX)
  end

  def is_console_session_token(token)
    is_jwt(token)
  end

  def is_personal_access_token(token)
    is_access_token(token)
  end
end
