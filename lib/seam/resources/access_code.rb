# frozen_string_literal: true

module Seam
  class AccessCode < BaseResource
    attr_reader :access_code_id, :name, :type, :code, :common_code_key, :is_managed, :status, :device_id, :is_scheduled_on_device, :is_waiting_for_code_assignment, :pulled_backup_access_code_id, :is_backup_access_code_available, :is_backup, :appearance, :is_external_modification_allowed

    date_accessor :starts_at, :ends_at, :created_at

    include Seam::ResourceErrorsSupport
    include Seam::ResourceWarningsSupport
  end
end
