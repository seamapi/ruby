# frozen_string_literal: true

require "spec_helper"

RSpec.describe Seam::Http::SingleWorkspace do
  let(:api_key) { "seam_test_api_key" }
  let(:endpoint) { "https://example.com" }
  let(:faraday_retry_options) do
    {
      max: 3,
      interval: 0.1,
      methods: %i[post],
      retry_statuses: [500]
    }
  end

  describe "retry options" do
    it "passes faraday_retry_options to the Faraday client and uses them" do
      client = described_class.new(
        api_key: api_key,
        endpoint: endpoint,
        faraday_retry_options: faraday_retry_options
      )

      stub_request(:post, "#{endpoint}/devices/list")
        .with(
          headers: {
            "Content-Type" => "application/json"
          }
        )
        .to_return(status: 500, body: {"error" => {"type" => "server_error", "message" => "Internal Server Error"}}.to_json, headers: {"Content-Type" => "application/json"})
        .to_return(status: 500, body: {"error" => {"type" => "server_error", "message" => "Internal Server Error"}}.to_json, headers: {"Content-Type" => "application/json"})
        .to_return(status: 200, body: {devices: []}.to_json, headers: {"Content-Type" => "application/json"})

      result = client.devices.list
      expect(result).to eq([])

      expect(a_request(:post, "#{endpoint}/devices/list")).to have_been_made.times(3)
    end
  end
end
