# frozen_string_literal: true

require "singleton"

module Seam
  # The type of the {Seam::NULL} sentinel.
  class Null
    include Singleton

    def to_s
      "NULL"
    end

    def inspect
      "NULL"
    end
  end

  # Sentinel for an explicit JSON null.
  #
  # The Seam API distinguishes three states for a parameter: absent (leave the
  # stored value unchanged), null (unset the stored value), and a value (set
  # it). Ruby's +nil+ means absent; +Seam::NULL+ means null. Only use it for
  # parameters the API documents as nullable. In a query string it serializes
  # as +name=+ and in a JSON body as +"name": null+.
  NULL = Null.instance
end
