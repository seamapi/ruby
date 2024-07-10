# frozen_string_literal: true

require "seam/utils/action_attempt_utils"

RSpec.describe Seam::Utils::ActionAttemptUtils do
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

  describe ".decide_and_wait" do
    context "when wait_for_action_attempt is true" do
      it "calls wait_until_finished" do
        expect(described_class).to receive(:wait_until_finished).with(action_attempt, client)
        described_class.decide_and_wait(action_attempt, client, true)
      end
    end

    context "when wait_for_action_attempt is a hash" do
      let(:wait_options) { {timeout: 10, polling_interval: 1} }

      it "calls wait_until_finished with options" do
        expect(described_class).to receive(:wait_until_finished).with(action_attempt, client, timeout: 10, polling_interval: 1)
        described_class.decide_and_wait(action_attempt, client, wait_options)
      end
    end

    context "when wait_for_action_attempt is nil" do
      it "uses the client's actual default wait_for_action_attempt value" do
        client_default = client.defaults["wait_for_action_attempt"]

        if client_default
          expect(described_class).to receive(:wait_until_finished).with(action_attempt, client)
        else
          expect(described_class).not_to receive(:wait_until_finished)
        end

        described_class.decide_and_wait(action_attempt, client, nil)
      end
    end
  end

  describe ".wait_until_finished" do
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

    let(:result) { described_class.wait_until_finished(action_attempt, client) }

    it "returns an updated ActionAttempt" do
      expect(result.status).to eq(finished_status)
    end

    context "when action attempt fails" do
      let(:status) { "failed" }
      let(:error_message) { "Something went wrong" }

      before do
        stub_seam_request(
          :post,
          "/action_attempts/get",
          {action_attempt: action_attempt_hash.merge(status: status, error: {"message" => error_message})}
        )
      end

      it "raises an error" do
        expect { described_class.wait_until_finished(action_attempt, client) }.to raise_error("Action Attempt failed: #{error_message}")
      end
    end

    context "when timeout is reached" do
      it "raises a timeout error" do
        expect { described_class.wait_until_finished(action_attempt, client, timeout: 0.1) }.to raise_error("Timed out waiting for action attempt to be finished")
      end
    end
  end

  describe ".update_action_attempt" do
    let(:updated_action_attempt_hash) { action_attempt_hash.merge(status: "finished") }
    before do
      stub_seam_request(
        :post,
        "/action_attempts/get",
        {action_attempt: updated_action_attempt_hash}
      ).with { |req| req.body.source == {action_attempt_id: action_attempt_id}.to_json }
    end

    it "updates the ActionAttempt" do
      updated_attempt = described_class.update_action_attempt(action_attempt, client)
      expect(updated_attempt.status).to eq("finished")
    end
  end
end
