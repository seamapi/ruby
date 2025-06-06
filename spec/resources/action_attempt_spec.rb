# frozen_string_literal: true

require "seam/helpers/action_attempt"

RSpec.describe Seam::Helpers::ActionAttempt do
  let(:seam) { Seam.new(api_key: "seam_some_api_key") }
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
  let(:action_attempt) { Seam::Resources::ActionAttempt.new(action_attempt_hash, seam) }

  describe ".decide_and_wait" do
    context "when wait_for_action_attempt is true" do
      it "calls wait_until_finished" do
        expect(described_class).to receive(:wait_until_finished).with(action_attempt, seam)
        described_class.decide_and_wait(action_attempt, seam, true)
      end
    end

    context "when wait_for_action_attempt is a hash" do
      let(:wait_options) { {timeout: 10, polling_interval: 1} }

      it "calls wait_until_finished with options" do
        expect(described_class).to receive(:wait_until_finished).with(action_attempt, seam, timeout: 10,
          polling_interval: 1)
        described_class.decide_and_wait(action_attempt, seam, wait_options)
      end
    end
  end

  describe ".wait_until_finished" do
    before do
      stub_seam_request(
        :get,
        "/action_attempts/get",
        {action_attempt: action_attempt_hash}
      ).with(query: {action_attempt_id: action_attempt_id})
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

    let(:result) { described_class.wait_until_finished(action_attempt, seam.client) }

    it "returns an updated ActionAttempt" do
      expect(result.status).to eq(finished_status)
      expect(result).to be_a(Seam::Resources::ActionAttempt)
    end
  end

  describe ".update_action_attempt" do
    let(:updated_action_attempt_hash) { action_attempt_hash.merge(status: "finished") }
    before do
      stub_seam_request(
        :get,
        "/action_attempts/get",
        {action_attempt: updated_action_attempt_hash}
      ).with(query: {action_attempt_id: action_attempt_id})
    end

    it "updates the ActionAttempt" do
      updated_attempt = described_class.update_action_attempt(action_attempt, seam.client)
      expect(updated_attempt.status).to eq("finished")
    end
  end
end
