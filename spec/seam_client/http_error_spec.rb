# frozen_string_literal: true

RSpec.describe Seam::Http, :fake do
  describe "unauthorized responses" do
    it "raises UnauthorizedError" do
      seam = Seam.new(api_key: "seam_invalid_api_key", endpoint: endpoint)

      expect { seam.devices.list }.to raise_error(Seam::Http::UnauthorizedError) do |error|
        expect(error.status_code).to eq(401)
        expect(error.code).to eq("unauthorized")
        expect(error.request_id).to start_with("request")
      end
    end
  end

  describe "standard error responses" do
    it "raises ApiError" do
      expect do
        seam.devices.get(device_id: "unknown-device")
      end.to raise_error(Seam::Http::ApiError) do |error|
        expect(error.status_code).to eq(404)
        expect(error.code).to eq("device_not_found")
        expect(error.request_id).to start_with("request")
      end
    end
  end

  describe "invalid input responses" do
    it "raises InvalidInputError carrying the validation errors" do
      expect do
        seam.client.post("/devices/list", {device_ids: 4242})
      end.to raise_error(Seam::Http::InvalidInputError) do |error|
        expect(error.status_code).to eq(400)
        expect(error.code).to eq("invalid_input")
        expect(error.request_id).to start_with("request")
        expect(error.get_validation_error_messages("device_ids"))
          .to eq(["Expected array, received number"])
      end
    end

    it "returns no messages for a param without validation errors" do
      expect do
        seam.client.post("/devices/list", {device_ids: 4242})
      end.to raise_error(Seam::Http::InvalidInputError) do |error|
        expect(error.get_validation_error_messages("non_existent_param")).to eq([])
      end
    end
  end

  describe "non-standard error responses" do
    it "raises a Faraday error" do
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
