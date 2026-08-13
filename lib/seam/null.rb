# frozen_string_literal: true

require "singleton"

module Seam
  # The type of the {Seam::NULL} sentinel.
  #
  # Exported alongside the sentinel so callers can reference the type itself,
  # e.g. in YARD documentation or case expressions. Detect the sentinel with
  # +value.is_a?(Seam::Null)+ rather than an identity check, which would break
  # if the library were somehow loaded twice.
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
  # it). Ruby's +nil+ has to mean one of the first two, and it means absent:
  # unsetting a value cannot be undone and is rarely intended, so it is never
  # the default and is always spelled explicitly as +Seam::NULL+.
  #
  # Only use +Seam::NULL+ for parameters the API documents as nullable. In a
  # query string it serializes as +name=+ and in a JSON body as +"name": null+.
  NULL = Null.instance
end
