# frozen_string_literal: true

RSpec.describe Seam::Client do
  let(:seam) { Seam::Client.new(api_key: "seam_some_api_key") }
  let(:request_id) { "request_id_1234" }

  describe "#request_seam" do
    context "when unauthorized error occurs" do
      before do
        stub_request(:post, "#{Seam::DEFAULT_ENDPOINT}/devices/list")
          .to_return(status: 401, headers: {"seam-request-id" => request_id})
      end

      it "raises SeamHttpUnauthorizedError" do
        expect { seam.devices.list }.to raise_error(Seam::SeamHttpUnauthorizedError) do |error|
          expect(error.message).to eq("Unauthorized")
          expect(error.request_id).to eq(request_id)
        end
      end
    end

    context "when invalid input error occurs" do
      let(:error_message) { "Invalid device_id provided" }
      let(:error_status) { 400 }
      let(:error_response) do
        {
          error: {
            type: "invalid_input",
            message: error_message
          }
        }.to_json
      end

      before do
        stub_request(:post, "#{Seam::DEFAULT_ENDPOINT}/devices/get")
          .to_return(status: error_status, body: error_response, headers: {"Content-Type" => "application/json", "seam-request-id" => request_id})
      end

      it "raises SeamHttpInvalidInputError" do
        expect { seam.devices.get(device_id: "invalid_device_id") }.to raise_error(Seam::SeamHttpInvalidInputError) do |error|
          expect(error.message).to eq(error_message)
          expect(error.status_code).to eq(error_status)
          expect(error.request_id).to eq(request_id)
        end
      end
    end

    context "when other API error occurs" do
      let(:error_message) { "An unknown error occurred" }
      let(:error_status) { 500 }
      let(:error_response) do
        {
          error: {
            type: "api_error",
            message: error_message,
            data: nil
          }
        }.to_json
      end

      before do
        stub_request(:post, "#{Seam::DEFAULT_ENDPOINT}/devices/list")
          .to_return(status: error_status, body: error_response, headers: {"Content-Type" => "application/json", "seam-request-id" => request_id})
      end

      it "raises SeamHttpApiError with the correct details" do
        expect { seam.devices.list }.to raise_error(Seam::SeamHttpApiError) do |error|
          expect(error.message).to eq(error_message)
          expect(error.status_code).to eq(error_status)
          expect(error.request_id).to eq(request_id)
          expect(error.data).to be_nil
        end
      end
    end
  end
end
