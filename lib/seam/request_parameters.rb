# frozen_string_literal: true

module Seam
  module RequestParameters
    def self.require_at_least_one(path, parameters, parameter_names)
      return if parameter_names.any? { |name| !parameters[name].nil? }

      raise TypeError, "At least one parameter is required for #{path}"
    end
  end
end
