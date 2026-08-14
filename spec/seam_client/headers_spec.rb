# frozen_string_literal: true

# The fake does not echo the request back, so WebMock is used here to assert on
# the headers the SDK actually sends.
RSpec.describe Seam::Http::Request do
  let(:device_id) { "device_id_1234" }

  it "sends the SDK and auth headers" do
    stub = stub_request(:get, "#{Seam::DEFAULT_ENDPOINT}/devices/get?device_id=#{device_id}&_strict=true")
      .with(
        headers: {
          "Authorization" => "Bearer seam_some_api_key",
          "Content-Type" => "application/json",
          "seam-sdk-name" => "seamapi/ruby",
          "seam-sdk-version" => Seam::VERSION,
          "User-Agent" => "seam-ruby/#{Seam::VERSION}"
        }
      )
      .to_return(
        status: 200,
        body: {device: {device_id: device_id}}.to_json,
        headers: {"Content-Type" => "application/json"}
      )

    seam = Seam.new(api_key: "seam_some_api_key")
    device = seam.devices.get(device_id: device_id)

    expect(device.device_id).to eq(device_id)
    expect(stub).to have_been_requested
  end

  it "sends the workspace header with a personal access token" do
    stub = stub_request(:get, "#{Seam::DEFAULT_ENDPOINT}/devices/get?device_id=#{device_id}&_strict=true")
      .with(
        headers: {
          "Authorization" => "Bearer seam_at_token",
          "seam-workspace" => "workspace_123"
        }
      )
      .to_return(
        status: 200,
        body: {device: {device_id: device_id}}.to_json,
        headers: {"Content-Type" => "application/json"}
      )

    seam = Seam.from_personal_access_token("seam_at_token", "workspace_123")
    seam.devices.get(device_id: device_id)

    expect(stub).to have_been_requested
  end
end
