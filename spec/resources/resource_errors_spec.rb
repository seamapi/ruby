# frozen_string_literal: true

RSpec.describe "resource errors and warnings" do
  describe "errors" do
    it "loads a known error code as its variant subclass" do
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
      expect(error).to be_a(Seam::Resources::Device::Errors::DeviceRemoved)
      expect(error).to be_a(Seam::Resources::Device::Errors)
      expect(error.error_code).to eq("device_removed")
      expect(error.message).to eq("Device was removed")
      expect(error.created_at).to be_a(Time)
    end

    it "only exposes fields declared by that error variant" do
      device = Seam::Resources::Device.load_from_response(
        "device_id" => "device_id_1234",
        "errors" => [
          {
            "error_code" => "device_offline",
            "message" => "Device is offline",
            "is_device_error" => true,
            "is_bridge_error" => false
          }
        ]
      )

      error = device.errors.first
      expect(error.is_device_error).to be(true)
      expect(error).not_to respond_to(:is_bridge_error)
    end

    it "uses the resource's base error class for unknown codes" do
      device = Seam::Resources::Device.load_from_response(
        "errors" => [{"error_code" => "future_error", "message" => "Future error"}]
      )

      error = device.errors.first
      expect(error).to be_an_instance_of(Seam::Resources::Device::Errors)
      expect(error.error_code).to eq("future_error")
      expect(error.message).to eq("Future error")
    end

    it "scopes errors to their own resource" do
      expect(Seam::Resources::Device::Errors).not_to be(Seam::Resources::AccessCode::Errors)
      expect(Seam::Resources::AccessCode::Errors::DuplicateCodeOnDevice.instance_methods)
        .to include(:managed_access_code_id)
      expect(Seam::Resources::Device::Errors::DeviceRemoved.instance_methods)
        .not_to include(:managed_access_code_id)
    end

    it "returns an empty array when the resource has no errors" do
      device = Seam::Resources::Device.load_from_response("device_id" => "device_id_1234")

      expect(device.errors).to eq([])
    end

    it "returns an empty array when the response sends null errors" do
      device = Seam::Resources::Device.load_from_response(
        "device_id" => "device_id_1234",
        "errors" => nil
      )

      expect(device.errors).to eq([])
    end
  end

  describe "warnings" do
    it "loads a known warning code as its variant subclass" do
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
      expect(warning).to be_a(Seam::Resources::Device::Warnings::PrivacyMode)
      expect(warning).to be_a(Seam::Resources::Device::Warnings)
      expect(warning.warning_code).to eq("privacy_mode")
      expect(warning.message).to eq("Device is in privacy mode")
      expect(warning.created_at).to be_a(Time)
    end

    it "exposes fields declared by that warning variant" do
      device = Seam::Resources::Device.load_from_response(
        "warnings" => [
          {
            "warning_code" => "max_access_codes_reached",
            "message" => "Too many active access codes",
            "active_access_code_count" => 12,
            "max_active_access_code_count" => 10
          }
        ]
      )

      warning = device.warnings.first
      expect(warning).to be_a(Seam::Resources::Device::Warnings::MaxAccessCodesReached)
      expect(warning.active_access_code_count).to eq(12)
      expect(warning.max_active_access_code_count).to eq(10)
    end

    it "uses the resource's base warning class for unknown codes" do
      device = Seam::Resources::Device.load_from_response(
        "warnings" => [{"warning_code" => "future_warning", "message" => "Future warning"}]
      )

      warning = device.warnings.first
      expect(warning).to be_an_instance_of(Seam::Resources::Device::Warnings)
      expect(warning.warning_code).to eq("future_warning")
      expect(warning.message).to eq("Future warning")
    end

    it "returns an empty array when the resource has no warnings" do
      device = Seam::Resources::Device.load_from_response("device_id" => "device_id_1234")

      expect(device.warnings).to eq([])
    end
  end

  describe "errors nested inside another shape" do
    it "types errors that are not at the top level of a resource" do
      device = Seam::Resources::Device.load_from_response(
        "device_id" => "device_id_1234",
        "properties" => {
          "active_thermostat_schedule" => {
            "errors" => [{"error_code" => "unknown", "message" => "Boom"}]
          }
        }
      )

      error = device.properties.active_thermostat_schedule.errors.first
      expect(error).to be_a(
        Seam::Resources::Device::Properties::ActiveThermostatSchedule::Errors
      )
      expect(error.message).to eq("Boom")
    end
  end
end
