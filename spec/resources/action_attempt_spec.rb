# frozen_string_literal: true

RSpec.describe Seam::ActionAttempt do
  let(:client) { Seam::Client.new(api_key: "seam_some_api_key") }
  let(:action_attempt_id) { "action_attempt_id_1234" }
  let(:finished_status) { "finished" }
  let(:action_attempt_hash) do
    {
      action_attempt_id: action_attempt_id,
      action_type: "some_action",
      status: "pending",
      result: {}
    }
  end
  let(:action_attempt) { Seam::ActionAttempt.new(action_attempt_hash, client) }

  describe "#wait_until_finished" do
    before do
      stub_seam_request(
        :post,
        "/action_attempts/get",
        {action_attempt: action_attempt_hash}
      ).with { |req| req.body.source == {action_attempt_id: action_attempt_id}.to_json }
        .times(2)
        .then
        .to_return(
          {
            status: 200,
            headers: {"Content-Type": "application/json"},
            body: {
              action_attempt: action_attempt_hash.merge(status: finished_status)
            }.to_json
          }
        )
    end

    let(:result) { action_attempt.wait_until_finished }

    it "returns a list of Devices" do
      expect(result.status).to eq(finished_status)
    end
  end

  describe "#update!" do
    let(:updated_action_attempt_hash) { action_attempt_hash.merge(status: "finished") }
    before do
      stub_seam_request(
        :post,
        "/action_attempts/get",
        {action_attempt: updated_action_attempt_hash}
      ).with { |req| req.body.source == {action_attempt_id: action_attempt_id}.to_json }
    end

    it "returns a list of Devices" do
      expect do
        action_attempt.update!
      end.to change {
        action_attempt.status
      }.from("pending").to "finished"
    end
  end
end
