# frozen_string_literal: true

module Seam
  module Resources
    # Information about the current page of results.
    class Pagination < BaseResource
      # Indicates whether there is another page of results after this one.
      attr_accessor :has_next_page
      # Opaque value that can be used to select the next page of results via the `page_cursor` parameter.
      attr_accessor :next_page_cursor
      # URL to get the next page of results.
      attr_accessor :next_page_url
    end
  end
end
