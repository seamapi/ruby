# frozen_string_literal: true

RSpec.describe Seam::Clients::AccessCodes do
  let(:client) { Seam.new(api_key: "seam_some_api_key") }

  describe "#get" do
    let(:action_attempt_id) { "action_attempt_id_1234" }
    let(:action_attempt_hash) { {action_attempt_id: action_attempt_id} }

    before do
      stub_seam_request(
        :post, "/action_attempts/get", {action_attempt: action_attempt_hash}
      ).with { |req| req.body == {action_attempt_id: action_attempt_id}.to_json }
    end

    let(:result) { client.action_attempts.get(action_attempt_id: action_attempt_id) }

    it "returns a Device" do
      expect(result).to be_a(Seam::Resources::ActionAttempt)
    end
  end
end
