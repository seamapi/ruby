# frozen_string_literal: true

RSpec.describe "the factory methods" do
  let(:url) { "#{Seam::DEFAULT_ENDPOINT}/devices/list" }

  def service_unavailable
    {
      status: 503,
      body: {error: {type: "service_unavailable", message: "Down"}}.to_json,
      headers: {"Content-Type" => "application/json"}
    }
  end

  shared_examples "a factory that accepts the advanced options" do
    it "passes faraday_options to the client" do
      seam = build(faraday_options: {headers: {"Custom-Header" => "Test-Value"}, request: {timeout: 45}})

      expect(seam.client.headers["Custom-Header"]).to eq("Test-Value")
      expect(seam.client.options.timeout).to eq(45)
    end

    it "passes faraday_retry_options to the client" do
      stub_request(:get, url).to_return(service_unavailable)

      seam = build(faraday_retry_options: {max: 0, interval: 0})

      expect { seam.devices.list }.to raise_error(Seam::Http::ApiError)
      expect(a_request(:get, url)).to have_been_made.once
    end
  end

  describe "Seam.from_api_key" do
    def build(**options)
      Seam.from_api_key("seam_some_api_key", **options)
    end

    include_examples "a factory that accepts the advanced options"
  end

  describe "Seam.from_personal_access_token" do
    def build(**options)
      Seam.from_personal_access_token("seam_at_token", "workspace-1", **options)
    end

    include_examples "a factory that accepts the advanced options"
  end

  describe "Seam::Http.from_api_key" do
    def build(**options)
      Seam::Http.from_api_key("seam_some_api_key", **options)
    end

    include_examples "a factory that accepts the advanced options"
  end

  describe "Seam::Http.from_personal_access_token" do
    def build(**options)
      Seam::Http.from_personal_access_token("seam_at_token", "workspace-1", **options)
    end

    include_examples "a factory that accepts the advanced options"
  end
end
