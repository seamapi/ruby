# frozen_string_literal: true

module Seam
  module Resources
    class Pagination < BaseResource
      attr_accessor :has_next_page, :next_page_cursor, :next_page_url
    end
  end
end
