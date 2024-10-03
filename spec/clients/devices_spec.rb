# frozen_string_literal: true

RSpec.describe Seam::Clients::Devices do
  let(:client) { Seam.new(api_key: "seam_some_api_key") }

  describe "#list" do
    let(:device_hash) { {device_id: "123"} }

    before do
      stub_seam_request(:post, "/devices/list", {devices: [device_hash]})
    end

    let(:devices) { client.devices.list }

    it "returns a list of Devices" do
      expect(devices).to be_a(Array)
      expect(devices.first).to be_a(Seam::Resources::Device)
      expect(devices.first.device_id).to be_a(String)
    end
  end

  describe "#get" do
    context "'device_id' param'" do
      let(:device_id) { "device_id_1234" }
      let(:device_hash) { {device_id: device_id, properties: {manufacturer: "august"}} }

      before do
        stub_seam_request(:post, "/devices/get", {device: device_hash}).with do |req|
          req.body.source == {device_id: device_id}.to_json
        end
      end

      let(:result) { client.devices.get(device_id: device_id) }

      it "returns a Device" do
        expect(result).to be_a(Seam::Resources::Device)
        expect(result.properties.manufacturer).to eq("august")
      end
    end

    context "'name' param'" do
      let(:name) { "name_1234" }
      let(:device_hash) { {name: name} }

      before do
        stub_seam_request(:post, "/devices/get", {device: device_hash}).with do |req|
          req.body.source == {name: name}.to_json
        end
      end

      let(:result) { client.devices.get(name: name) }

      it "returns a Device" do
        expect(result).to be_a(Seam::Resources::Device)
      end
    end
  end

  describe "#get with errors" do
    let(:device_id) { "device_id_1234" }
    let(:device_hash) { {device_id: device_id} }
    let(:device_removed_error) { {error_code: "device_removed", message: "Device was removed"} }
    let(:device_privacy_warning) { {warning_code: "privacy_mode", message: "Device is in privacy mode"} }

    before do
      stub_seam_request(:post, "/devices/get", {
        device: device_hash.merge(
          errors: [device_removed_error],
          warnings: [device_privacy_warning]
        )
      }).with { |req| req.body.source == {device_id: device_id}.to_json }
    end

    let(:result) { client.devices.get(device_id: device_id) }

    it "returns a Device" do
      expect(result).to be_a(Seam::Resources::Device)
    end

    it "returns device errors" do
      expect(result.errors.first.error_code).to eq("device_removed")
    end

    it "returns device warnings" do
      expect(result.warnings.first.warning_code).to eq("privacy_mode")
    end
  end

  let(:device_provider_hash) do
    {
      device_provider_name: "august",
      display_name: "August",
      provider_categories: ["stable"]
    }
  end
  let(:stable_device_provider_hash) do
    {
      device_provider_name: "akuvox",
      display_name: "Akuvox",
      provider_categories: []
    }
  end

  describe "#list_device_providers" do
    before do
      stub_seam_request(:post, "/devices/list_device_providers",
        {device_providers: [device_provider_hash, stable_device_provider_hash]})
    end

    let(:device_providers) { client.devices.list_device_providers }

    it "returns a list of stable Device Providers" do
      expect(device_providers).to be_a(Array)
      expect(device_providers.length).to eq(2)
      expect(device_providers.first).to be_a(Seam::Resources::DeviceProvider)
      expect(device_providers.first.device_provider_name).to be_a(String)
      expect(device_providers.first.display_name).to be_a(String)
      expect(device_providers.first.provider_categories).to be_a(Array)
    end
  end

  describe "#list_device_providers (provider_category=stable)" do
    before do
      stub_seam_request(:post, "/devices/list_device_providers",
        {device_providers: [stable_device_provider_hash]})
        .with { |req| req.body.source == {provider_category: "stable"}.to_json }
    end

    let(:device_providers) { client.devices.list_device_providers(provider_category: "stable") }

    it "returns a list of stable Device Providers" do
      expect(device_providers).to be_a(Array)
      expect(device_providers.length).to eq(1)

      expect(device_providers.first).to be_a(Seam::Resources::DeviceProvider)
      expect(device_providers.first.device_provider_name).to be_a(String)
      expect(device_providers.first.display_name).to be_a(String)
      expect(device_providers.first.provider_categories).to be_a(Array)
    end
  end

  describe "#update device" do
    let(:device_id) { "device_id_1234" }
    let(:name) { "New Device Name" }

    before do
      stub_seam_request(:post, "/devices/update", nil)
        .with do |req|
          req.body.source == {device_id: device_id, name: name}.to_json
        end
    end

    let(:response) { client.devices.update(device_id: device_id, name: name) }

    it "returns success" do
      expect(response).to be_a(NilClass)
    end
  end
end
