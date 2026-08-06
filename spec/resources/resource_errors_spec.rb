# frozen_string_literal: true

RSpec.describe "resource errors and warnings" do
  describe Seam::Resources::ResourceErrorsSupport do
    it "converts error hashes into ResourceError objects" do
      device = Seam::Resources::Device.load_from_response(
        "device_id" => "device_id_1234",
        "errors" => [
          {
            "error_code" => "device_removed",
            "message" => "Device was removed",
            "created_at" => "2024-01-01T00:00:00Z"
          }
        ]
      )

      error = device.errors.first
      expect(error).to be_a(Seam::Resources::ResourceError)
      expect(error.error_code).to eq("device_removed")
      expect(error.message).to eq("Device was removed")
      expect(error.created_at).to be_a(Time)
    end

    it "returns an empty array when the resource has no errors" do
      device = Seam::Resources::Device.load_from_response("device_id" => "device_id_1234")

      expect(device.errors).to eq([])
    end
  end

  describe Seam::Resources::ResourceWarningsSupport do
    it "converts warning hashes into ResourceWarning objects" do
      device = Seam::Resources::Device.load_from_response(
        "device_id" => "device_id_1234",
        "warnings" => [
          {
            "warning_code" => "privacy_mode",
            "message" => "Device is in privacy mode",
            "created_at" => "2024-01-01T00:00:00Z"
          }
        ]
      )

      warning = device.warnings.first
      expect(warning).to be_a(Seam::Resources::ResourceWarning)
      expect(warning.warning_code).to eq("privacy_mode")
      expect(warning.message).to eq("Device is in privacy mode")
      expect(warning.created_at).to be_a(Time)
    end

    it "returns an empty array when the resource has no warnings" do
      device = Seam::Resources::Device.load_from_response("device_id" => "device_id_1234")

      expect(device.warnings).to eq([])
    end
  end
end
