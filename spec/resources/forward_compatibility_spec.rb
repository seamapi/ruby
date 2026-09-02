# frozen_string_literal: true

RSpec.describe "forward compatibility" do
  it "reads an unknown enum value as itself" do
    device = Seam::Resources::Device.load_from_response(
      "device_id" => "device_1", "device_type" => "future_lock"
    )

    expect(device.device_type).to eq("future_lock")
  end

  it "falls back to a generic event for an unknown event type" do
    event = Seam::Resources::SeamEvent.load_from_response(
      "event_id" => "event_1", "event_type" => "future.thing"
    )

    expect(event.class).to eq(Seam::Resources::SeamEvent)
    expect(event.event_type).to eq("future.thing")
  end

  it "keeps the rest of the resource when an error code is unknown" do
    device = Seam::Resources::Device.load_from_response(
      "device_id" => "device_1",
      "errors" => [{"error_code" => "brand_new", "message" => "m"}]
    )

    expect(device.device_id).to eq("device_1")
    expect(device.errors.first.class).to eq(Seam::Resources::Device::Errors)
    expect(device.errors.first.error_code).to eq("brand_new")
  end

  it "reads an unknown action attempt status as itself" do
    attempt = Seam::Resources::ActionAttempt.load_from_response(
      "action_attempt_id" => "attempt_1",
      "action_type" => "LOCK_DOOR",
      "status" => "cancelled"
    )

    expect(attempt.status).to eq("cancelled")
  end
end

RSpec.describe Seam::ActionAttemptUnknownStatusError do
  it "is raised rather than returning an unresolved attempt as a success" do
    attempt = Seam::Resources::ActionAttempt.load_from_response(
      "action_attempt_id" => "attempt_1",
      "action_type" => "LOCK_DOOR",
      "status" => "cancelled"
    )

    expect {
      Seam::ActionAttemptResolver.resolve(attempt, nil, true)
    }.to raise_error(described_class, /cancelled/)
  end

  it "subclasses ActionAttemptError so existing handlers keep working" do
    expect(described_class.ancestors).to include(Seam::ActionAttemptError)
  end
end

RSpec.describe "raw_json" do
  it "recovers a field the generated accessors drop" do
    payload = {"event_id" => "event_1", "event_type" => "access_code.created",
               "brand_new_field" => "kept"}

    event = Seam::Resources::SeamEvent.load_from_response(payload)

    expect(event).not_to respond_to(:brand_new_field)
    expect(JSON.parse(event.raw_json)).to eq(payload)
  end

  it "round-trips an unrecognized event" do
    payload = {"event_id" => "event_1", "event_type" => "future.thing", "x" => 1}

    event = Seam::Resources::SeamEvent.load_from_response(payload)

    expect(JSON.parse(event.raw_json)).to eq(payload)
  end

  it "is scoped to events" do
    device = Seam::Resources::Device.load_from_response("device_id" => "device_1")

    expect(device).not_to respond_to(:raw_json)
  end
end
