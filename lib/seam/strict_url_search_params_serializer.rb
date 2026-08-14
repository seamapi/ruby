# frozen_string_literal: true

require_relative "url_search_params_serializer"

# Strict serialization, used by the SDK itself: _strict=true is added to any
# non-empty query so the Seam API uses strict, schema-aware parsing.
module Seam
  # (see UrlSearchParamsSerializer.serialize_url_search_params)
  def self.serialize_url_search_params(params)
    UrlSearchParamsSerializer.serialize_url_search_params(params, strict: true)
  end

  # (see UrlSearchParamsSerializer.update_url_search_params)
  def self.update_url_search_params(search_params, params)
    UrlSearchParamsSerializer.update_url_search_params(search_params, params, strict: true)
  end
end
