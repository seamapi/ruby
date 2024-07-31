require "spec_helper"

RSpec.describe Seam::Errors::SeamHttpInvalidInputError do
  let(:api_key) { "seam_apikey1_token" }
  let(:client) { Seam::Client.new(api_key: api_key) }

  describe "handling invalid input errors" do
    let(:error_response) do
      {
        error: {
          type: "invalid_input",
          message: "Invalid input",
          validation_errors: {
            device_ids: {
              _errors: ["Expected array, received number"]
            }
          }
        }
      }
    end

    it "raises SeamHttpInvalidInputError with correct validation messages" do
      stub_seam_request(:post, "/devices/list",
        error_response,
        status: 400).with do |req|
        req.body.source == {device_ids: 123}.to_json
      end

      expect {
        client.devices.list(device_ids: 123)
      }.to raise_error(Seam::Errors::SeamHttpInvalidInputError) do |error|
        expect(error.code).to eq("invalid_input")
        expect(error.status_code).to eq(400)
        expect(error.get_validation_error_messages("device_ids")).to eq(["Expected array, received number"])
      end
    end

    it "returns an empty array for non-existent validation errors" do
      stub_seam_request(:post, "/devices/list",
        error_response,
        status: 400).with do |req|
        req.body.source == {device_ids: 123}.to_json
      end

      begin
        client.devices.list(device_ids: 123)
      rescue Seam::Errors::SeamHttpInvalidInputError => error
        expect(error.get_validation_error_messages("non_existent_field")).to eq([])
      end
    end
  end
end
