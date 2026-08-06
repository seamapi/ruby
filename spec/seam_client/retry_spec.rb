# frozen_string_literal: true

RSpec.describe Seam::Http::Request do
  let(:url) { "#{Seam::DEFAULT_ENDPOINT}/devices/list" }

  def service_unavailable
    {
      status: 503,
      body: {error: {type: "service_unavailable", message: "Down"}}.to_json,
      headers: {"Content-Type" => "application/json"}
    }
  end

  def devices
    {
      status: 200,
      body: {devices: []}.to_json,
      headers: {"Content-Type" => "application/json"}
    }
  end

  # WebMock is used here because counting attempts is the point, and the fake
  # keeps a simulated outage in place for every request.
  describe "faraday_retry_options" do
    it "retries until the request succeeds" do
      stub_request(:post, url)
        .to_return(service_unavailable)
        .to_return(service_unavailable)
        .to_return(devices)

      seam = Seam.new(
        api_key: "seam_some_api_key",
        faraday_retry_options: {max: 3, interval: 0, methods: %i[post], retry_statuses: [503]}
      )

      expect(seam.devices.list).to eq([])
      expect(a_request(:post, url)).to have_been_made.times(3)
    end

    it "gives up once the retries are exhausted" do
      stub_request(:post, url).to_return(service_unavailable)

      seam = Seam.new(
        api_key: "seam_some_api_key",
        faraday_retry_options: {max: 2, interval: 0, methods: %i[post], retry_statuses: [503]}
      )

      expect { seam.devices.list }.to raise_error(Seam::Http::ApiError)
      expect(a_request(:post, url)).to have_been_made.times(3)
    end

    it "does not retry when max is zero" do
      stub_request(:post, url).to_return(service_unavailable)

      seam = Seam.new(
        api_key: "seam_some_api_key",
        faraday_retry_options: {max: 0, interval: 0, methods: %i[post], retry_statuses: [503]}
      )

      expect { seam.devices.list }.to raise_error(Seam::Http::ApiError)
      expect(a_request(:post, url)).to have_been_made.times(1)
    end

    it "does not retry POST requests by default" do
      stub_request(:post, url).to_return(service_unavailable)

      seam = Seam.new(api_key: "seam_some_api_key", faraday_retry_options: {interval: 0})

      expect { seam.devices.list }.to raise_error(Seam::Http::ApiError)
      expect(a_request(:post, url)).to have_been_made.times(1)
    end
  end

  describe "a workspace outage", :fake do
    it "surfaces the error to the caller" do
      seam.client.post(
        "/_fake/simulate_workspace_outage",
        {workspace_id: seed["seed_workspace_1"], routes: ["/devices/list"]}
      )

      expect { seam.devices.list }.to raise_error(Faraday::Error) do |error|
        expect(error.response[:status]).to eq(503)
      end
    end
  end
end
