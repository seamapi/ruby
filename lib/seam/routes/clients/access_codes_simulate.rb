# frozen_string_literal: true

module Seam
  module Clients
    class AccessCodesSimulate < BaseClient
      def create_unmanaged_access_code(code:, device_id:, name:)
        request_seam_object(
          :post,
          "/access_codes/simulate/create_unmanaged_access_code",
          Seam::UnmanagedAccessCode,
          "access_code",
          body: {code: code, device_id: device_id, name: name}.compact
        )
      end
    end
  end
end
