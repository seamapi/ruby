# frozen_string_literal: true

RSpec.describe Seam::Resources::BaseResource do
  describe "hash handling" do
    let(:client) { Seam.new(api_key: "seam_some_api_key") }

    it "does not wrap empty hashes in DeepHashAccessor" do
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
  end
end
