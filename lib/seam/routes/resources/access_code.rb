# frozen_string_literal: true

module Seam
  class AccessCode < BaseResource
    attr_accessor :access_code_id, :code, :common_code_key, :device_id, :is_backup, :is_backup_access_code_available, :is_external_modification_allowed, :is_managed, :is_offline_access_code, :is_one_time_use, :is_scheduled_on_device, :is_waiting_for_code_assignment, :name, :pulled_backup_access_code_id, :status, :type

    date_accessor :created_at, :ends_at, :starts_at

    include Seam::ResourceErrorsSupport
    include Seam::ResourceWarningsSupport
  end
end
