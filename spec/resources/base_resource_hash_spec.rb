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

    it "keeps every variant field when merged into one class" do
      encoded = Seam::Resources::ActionAttempt.new(
        action_type: "ENCODE_ACS_CREDENTIAL",
        result: {
          acs_credential_on_encoder: {card_number: "123"},
          acs_credential_on_seam: {acs_credential_id: "cred_1"}
        }
      )

      expect(encoded.result.acs_credential_on_encoder.card_number).to eq("123")
      expect(encoded.result.acs_credential_on_seam.acs_credential_id).to eq("cred_1")

      instant_key = Seam::Resources::ActionAttempt.new(
        action_type: "CREATE_INSTANT_KEY",
        result: {instant_key_url: "https://example.com"}
      )

      expect(instant_key.result.instant_key_url).to eq("https://example.com")

      # A field from a third variant, on the same merged class.
      expect(instant_key.result).to respond_to(:was_confirmed_by_device)
    end

    it "merges variant fields recursively into nested objects" do
      from = Seam::Resources::AcsUser::PendingMutations::From

      # Each of these arrives from a different pending mutation variant.
      expect(from.instance_methods).to include(:full_name, :starts_at, :is_suspended,
        :acs_access_group_id)
    end
  end
end
