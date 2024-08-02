# frozen_string_literal: true

RSpec.describe Seam::Client do
  let(:seam) { Seam::Client.new(api_key: "seam_some_api_key") }

  describe "#initialize" do
    it "initializes Seam with fixture" do
      expect(seam.lts_version).not_to be_nil
      expect(seam.wait_for_action_attempt).to be true
    end
  end
end
