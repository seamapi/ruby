# frozen_string_literal: true

require_relative "seam/version"
require_relative "seam/lts_version"
require_relative "seam/request"
require_relative "seam/logger"
require_relative "seam/client"
require_relative "seam/base_client"
require_relative "seam/base_resource"

require_relative "seam/routes/resources/resource_errors_support"
require_relative "seam/routes/resources/resource_warnings_support"

Dir["#{__dir__}/seam/routes/resources/*.rb"].each do |file|
  next if file.end_with?("resource_errors_support.rb", "resource_warnings_support.rb")

  require_relative file
end
Dir["#{__dir__}/seam/routes/clients/*.rb"].each { |file| require_relative file }

module Seam
end
