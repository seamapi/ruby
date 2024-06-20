# frozen_string_literal: true

RSpec.describe Seam::Clients::DevicesUnmanaged do
  let(:client) { Seam::Client.new(api_key: "seam_some_api_key") }

  describe "#get" do
    context "'device_id' param" do
      let(:device_id) { "123" }
      let(:device_hash) { {device_id: device_id} }

      before do
        stub_seam_request(
          :post, "/devices/unmanaged/get", {device: device_hash}
        ).with { |req| req.body.source == {device_id: device_id}.to_json }
      end

      let(:result) { client.unmanaged_devices.get(device_id: device_id) }

      it "returns an unmanaged Device" do
        expect(result).to be_a(Seam::UnmanagedDevice)
      end
    end

    context "'name' param" do
      let(:name) { "name 123" }
      let(:device_hash) { {name: name} }

      before do
        stub_seam_request(
          :post, "/devices/unmanaged/get", {device: device_hash}
        ).with { |req| req.body.source == {name: name}.to_json }
      end

      let(:result) { client.unmanaged_devices.get(name: name) }

      it "returns an unmanaged Device" do
        expect(result).to be_a(Seam::UnmanagedDevice)
      end
    end
  end

  describe "#list" do
    let(:device_hash) { {device_id: "123"} }

    before do
      stub_seam_request(:post, "/devices/unmanaged/list", {devices: [device_hash]})
    end

    let(:unmanaged_devices) { client.unmanaged_devices.list }

    it "returns a list of unmanaged Devices" do
      expect(unmanaged_devices).to be_a(Array)
      expect(unmanaged_devices.first).to be_a(Seam::UnmanagedDevice)
      expect(unmanaged_devices.first.device_id).to be_a(String)
    end
  end

  describe "#update unmanaged device" do
    let(:device_id) { "device_id_1234" }
    let(:is_managed) { true }

    before do
      stub_seam_request(:post, "/devices/unmanaged/update", nil)
        .with do |req|
          req.body.source == {device_id: device_id, is_managed: is_managed}.to_json
        end
    end

    let(:response) { client.unmanaged_devices.update(device_id: device_id, is_managed: is_managed) }

    it "returns success" do
      expect(response).to be_a(NilClass)
    end
  end
end
