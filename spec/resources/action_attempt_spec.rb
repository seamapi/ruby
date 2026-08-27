# frozen_string_literal: true

RSpec.describe Seam::Resources::ActionAttempt do
  describe "status-scoped accessors" do
    it "returns nil for error and result while the attempt is pending" do
      attempt = described_class.load_from_response(
        "action_type" => "LOCK_DOOR",
        "status" => "pending",
        "error" => {"message" => "stale", "type" => "stale_error"},
        "result" => {"was_confirmed_by_device" => true}
      )

      expect(attempt.error).to be_nil
      expect(attempt.result).to be_nil
    end

    it "returns the result and a nil error for a successful attempt" do
      attempt = described_class.load_from_response(
        "action_type" => "LOCK_DOOR",
        "status" => "success",
        "error" => nil,
        "result" => {"was_confirmed_by_device" => true}
      )

      expect(attempt.error).to be_nil
      expect(attempt.result.was_confirmed_by_device).to be(true)
    end

    it "returns the error and a nil result for a failed attempt" do
      attempt = described_class.load_from_response(
        "action_type" => "LOCK_DOOR",
        "status" => "error",
        "error" => {"message" => "Failed to lock", "type" => "lock_error"},
        "result" => nil
      )

      expect(attempt.result).to be_nil
      expect(attempt.error.message).to eq("Failed to lock")
      expect(attempt.error.type).to eq("lock_error")
    end

    it "scopes error and result on unknown action types" do
      attempt = described_class.load_from_response(
        "action_type" => "FUTURE_ACTION",
        "status" => "pending",
        "error" => {"message" => "stale"},
        "result" => {}
      )

      expect(attempt).to be_an_instance_of(described_class)
      expect(attempt.error).to be_nil
      expect(attempt.result).to be_nil
    end
  end

  describe "generated documentation" do
    let(:source) do
      File.read(
        File.expand_path("../../lib/seam/resources/action_attempt.rb", __dir__),
        encoding: "UTF-8"
      )
    end

    it "documents error as only present for its statuses" do
      expect(source).to include("# Only present when `status` is `error`; `nil` otherwise.")
    end

    it "documents result as only present for its statuses" do
      expect(source).to include("# Only present when `status` is `success`; `nil` otherwise.")
    end

    it "does not imply error or result are always populated" do
      expect(source).not_to match(/# @return \[Error\]\s*$/)
      expect(source).not_to match(/# @return \[Result\]\s*$/)
    end
  end
end

RSpec.describe Seam::ActionAttemptFailedError do
  def failed_attempt(error)
    Seam::Resources::ActionAttempt.load_from_response(
      "action_type" => "LOCK_DOOR",
      "action_attempt_id" => "attempt_1",
      "status" => "error",
      "error" => error
    )
  end

  it "carries the error message and code when the error is present" do
    error = described_class.new(
      failed_attempt("message" => "Failed to lock", "type" => "lock_error")
    )

    expect(error.message).to eq("Failed to lock")
    expect(error.code).to eq("lock_error")
  end

  it "falls back to a generic message when the error is missing" do
    attempt = failed_attempt(nil)

    error = nil
    expect { error = described_class.new(attempt) }.not_to raise_error

    expect(error.message).to eq("Action attempt failed")
    expect(error.code).to be_nil
    expect(error.action_attempt).to be(attempt)
  end

  it "is raised by the resolver even when the error is missing" do
    attempt = failed_attempt(nil)

    expect do
      Seam::ActionAttemptResolver.resolve(attempt, nil, true)
    end.to raise_error(described_class, "Action attempt failed")
  end

  it "leaves the code nil when the error has no type" do
    attempt = Seam::Resources::ActionAttempt.load_from_response(
      "action_type" => "FUTURE_ACTION",
      "status" => "error",
      "error" => {"message" => "Failed"}
    )

    error = described_class.new(attempt)

    expect(error.message).to eq("Failed")
    expect(error.code).to be_nil
  end
end
