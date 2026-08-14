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

  # Sentinel for an explicit JSON null: +nil+ omits a parameter, +Seam::NULL+
  # unsets its stored value. Only for parameters the API documents as
  # nullable.
  NULL = Null.instance
end
