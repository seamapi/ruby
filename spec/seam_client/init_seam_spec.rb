# frozen_string_literal: true

RSpec.describe Seam::Http do
  let(:seam) { Seam.new(api_key: "seam_some_api_key") }

  describe "#initialize" do
    it "initializes Seam with fixture" do
      expect(Seam.lts_version).not_to be_nil
      expect(seam.lts_version).not_to be_nil
      expect(seam.defaults.wait_for_action_attempt).to be true
    end
  end
end
