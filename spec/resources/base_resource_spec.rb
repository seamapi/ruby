# frozen_string_literal: true

RSpec.describe Seam::Resources::BaseResource do
  let(:client) { Seam.new(api_key: "seam_some_api_key") }
  let(:device_hash) do
    {
      device_id: "device_id_1234",
      created_at: "2022-06-07T22:34:14.488Z"
    }
  end
  let(:device) { Seam::Resources::Device.new(device_hash) }

  describe ".date_accessor" do
    it "parses a date string" do
      expect(device.created_at).to be_a(Time)
    end
  end
end
