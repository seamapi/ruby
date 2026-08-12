# frozen_string_literal: true

RSpec.describe Seam::Resources::BaseResource do
  describe "hash handling" do
    let(:client) { Seam.new(api_key: "seam_some_api_key") }

    it "does not wrap undeclared empty hashes in DeepHashAccessor" do
      data = {
        device_id: "123",
        empty_hash: {},
        non_empty_hash: {key: "value"}
      }

      resource = described_class.new(data, client)

      expect(resource.instance_variable_get(:@empty_hash)).to eq({})
      expect(resource.instance_variable_get(:@empty_hash)).to be_a(Hash)
      expect(resource.instance_variable_get(:@empty_hash)).not_to be_a(Seam::DeepHashAccessor)

      expect(resource.instance_variable_get(:@non_empty_hash)).to be_a(Seam::DeepHashAccessor)
    end

    it "uses generated resources for declared nested objects" do
      device = Seam::Resources::Device.new(
        properties: {locked: true},
        custom_metadata: {customer_id: "customer-1"}
      )

      expect(device.properties).to be_a(Seam::Resources::Device::Properties)
      expect(device.properties.locked).to be(true)
      expect(device.properties[:locked]).to be(true)
      expect { device.properties.unknown }.to raise_error(NoMethodError)
      expect(device.custom_metadata).to be_a(Seam::DeepHashAccessor)
      expect(device.custom_metadata.customer_id).to eq("customer-1")
    end

    it "uses a generated resource for an empty declared object" do
      device = Seam::Resources::Device.new(properties: {})

      expect(device.properties).to be_a(Seam::Resources::Device::Properties)
    end

    it "scopes nested resources so same-named objects keep distinct shapes" do
      device = Seam::Resources::Device.new(
        properties: {
          battery: {level: 0.5, status: "good"},
          accessory_keypad: {battery: {level: 0.25}}
        }
      )

      expect(device.properties.battery).to be_a(Seam::Resources::Device::Properties::Battery)
      expect(device.properties.battery.status).to eq("good")

      keypad_battery = device.properties.accessory_keypad.battery
      expect(keypad_battery).to be_a(Seam::Resources::Device::Properties::AccessoryKeypad::Battery)
      expect(keypad_battery.level).to eq(0.25)
      expect(keypad_battery).not_to be_a(Seam::Resources::Device::Properties::Battery)
    end
  end
end
