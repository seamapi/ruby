# frozen_string_literal: true

RSpec.describe "discriminated resources" do
  describe Seam::Resources::SeamEvent do
    it "loads known event types as SeamEvent subclasses" do
      event = described_class.load_from_response(
        "event_type" => "access_code.created",
        "access_code_id" => "access_code_1"
      )

      expect(event).to be_a(described_class)
      expect(event).to be_a(described_class::AccessCodeCreated)
      expect(event.access_code_id).to eq("access_code_1")
      expect(event).not_to respond_to(:temperature_celsius)
    end

    it "keeps unknown event types as generic SeamEvent instances" do
      event = described_class.load_from_response(
        "event_type" => "future.event",
        "event_id" => "event_1"
      )

      expect(event).to be_an_instance_of(described_class)
      expect(event.event_type).to eq("future.event")
      expect(event.event_id).to eq("event_1")
    end

    it "renames the event method field without shadowing Object#method" do
      event = described_class.load_from_response(
        "event_type" => "lock.locked",
        "method" => "manual"
      )

      expect(event.event_method).to eq("manual")
      expect(event.method(:event_method).call).to eq("manual")
      expect(described_class::LockLocked.instance_methods(false)).not_to include(:method)
    end
  end

  describe Seam::Resources::ActionAttempt do
    it "loads known action types with action-specific results" do
      attempt = described_class.load_from_response(
        action_type: "LOCK_DOOR",
        status: "success",
        error: nil,
        result: {was_confirmed_by_device: true}
      )

      expect(attempt).to be_a(described_class)
      expect(attempt).to be_a(described_class::LockDoor)
      expect(attempt.error).to be_nil
      expect(attempt.result).to be_a(described_class::LockDoor::Result)
      expect(attempt.result.was_confirmed_by_device).to be(true)
    end

    it "allows pending attempts to have nil errors and results" do
      attempt = described_class.load_from_response(
        action_type: "UNLOCK_DOOR",
        status: "pending",
        error: nil,
        result: nil
      )

      expect(attempt.error).to be_nil
      expect(attempt.result).to be_nil
    end

    it "keeps unknown action types as generic ActionAttempt instances" do
      attempt = described_class.load_from_response(
        action_type: "FUTURE_ACTION",
        status: "error",
        error: {message: "Future error"}
      )

      expect(attempt).to be_an_instance_of(described_class)
      expect(attempt.action_type).to eq("FUTURE_ACTION")
      expect(attempt.error).to be_a(described_class::Error)
      expect(attempt.error.message).to eq("Future error")
    end
  end
end
