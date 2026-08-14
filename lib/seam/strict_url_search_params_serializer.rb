# frozen_string_literal: true

require_relative "url_search_params_serializer"

# The strict URL search params serialization used by the Seam SDK: the base
# serializer with strict mode enabled, adding _strict=true to any non-empty
# query so the Seam API uses strict, schema-aware parsing.
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
