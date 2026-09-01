# frozen_string_literal: true

# Reading a response must not fail on the shape of the payload.
RSpec.describe "total parsing" do
  it "does not raise when the payload is not an object" do
    resource = Seam::Resources::Device.load_from_response(42)

    expect(resource).to be_a(Seam::Resources::Device)
    expect(resource.device_id).to be_nil
  end

  it "does not raise when a list payload holds values that are not objects" do
    resources = Seam::Resources::Device.load_from_response([1, 2])

    expect(resources.map(&:class)).to eq(
      [Seam::Resources::Device, Seam::Resources::Device]
    )
  end

  it "reads a list property sent as a scalar as empty" do
    device = Seam::Resources::Device.load_from_response(
      "device_id" => "device_1", "errors" => "oops"
    )

    expect(device.errors).to eq([])
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

  it "reads a malformed timestamp as nil" do
    device = Seam::Resources::Device.load_from_response(
      "device_id" => "device_1", "created_at" => "not a timestamp"
    )

    expect(device.created_at).to be_nil
  end

  it "reads a timestamp of the wrong type as nil" do
    device = Seam::Resources::Device.load_from_response(
      "device_id" => "device_1", "created_at" => 12345
    )

    expect(device.created_at).to be_nil
  end

  it "still parses a well-formed timestamp" do
    device = Seam::Resources::Device.load_from_response(
      "device_id" => "device_1", "created_at" => "2024-01-01T00:00:00Z"
    )

    expect(device.created_at).to be_a(Time)
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
