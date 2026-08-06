# frozen_string_literal: true

# The fake cannot produce malformed error responses, so WebMock drives the
# bodies that must fall through seam_api_error_response? to Faraday's own
# error handling rather than being parsed into a Seam::Http::ApiError.
RSpec.describe Seam::Http::Request do
  let(:seam) { Seam.new(api_key: "seam_some_api_key") }
  let(:url) { "#{Seam::DEFAULT_ENDPOINT}/devices/list" }

  describe "non-Seam error responses" do
    it "raises a Faraday error for a plain text response" do
      stub_request(:post, url).to_return(
        status: 500,
        body: "Internal Server Error",
        headers: {"Content-Type" => "text/plain"}
      )

      expect { seam.devices.list }.to raise_error(Faraday::ServerError)
    end

    it "raises a Faraday error for malformed JSON" do
      stub_request(:post, url).to_return(
        status: 500,
        body: "{invalid json",
        headers: {"Content-Type" => "application/json"}
      )

      expect { seam.devices.list }.to raise_error(Faraday::ServerError)
    end

    it "raises a Faraday error for JSON without an error object" do
      stub_request(:post, url).to_return(
        status: 500,
        body: {message: "Some error"}.to_json,
        headers: {"Content-Type" => "application/json"}
      )

      expect { seam.devices.list }.to raise_error(Faraday::ServerError)
    end

    it "raises a Faraday error for an error object without a type and message" do
      stub_request(:post, url).to_return(
        status: 500,
        body: {error: {code: 500}}.to_json,
        headers: {"Content-Type" => "application/json"}
      )

      expect { seam.devices.list }.to raise_error(Faraday::ServerError)
    end
  end
end
