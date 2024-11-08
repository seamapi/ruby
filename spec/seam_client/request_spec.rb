# frozen_string_literal: true

RSpec.describe Seam::Http do
  let(:seam) { Seam.new(api_key: "seam_some_api_key") }
  let(:request_id) { "request_id_1234" }

  describe "#request_seam" do
    context "when unauthorized error occurs" do
      before do
        stub_request(:post, "#{Seam::DEFAULT_ENDPOINT}/devices/list")
          .to_return(status: 401, headers: {"seam-request-id" => request_id})
      end

      it "raises UnauthorizedError" do
        expect { seam.devices.list }.to raise_error(Seam::Http::UnauthorizedError) do |error|
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
          .to_return(status: error_status, body: error_response, headers: {"Content-Type" => "application/json",
                                                                           "seam-request-id" => request_id})
      end

      it "raises InvalidInputError" do
        expect do
          seam.devices.get(device_id: "invalid_device_id")
        end.to raise_error(Seam::Http::InvalidInputError) do |error|
          expect(error.message).to eq(error_message)
          expect(error.status_code).to eq(error_status)
          expect(error.request_id).to eq(request_id)
        end
      end
    end

    context "when non-Seam API error occurs" do
      let(:error_status) { 500 }
      let(:error_response) { "Internal Server Error" }

      before do
        stub_request(:post, "#{Seam::DEFAULT_ENDPOINT}/devices/list")
          .to_return(status: error_status, body: error_response, headers: {"Content-Type" => "text/plain"})
      end

      it "raises Faraday error" do
        expect { seam.devices.list }.to raise_error(Faraday::ServerError)
      end
    end

    context "when malformed JSON response" do
      let(:error_status) { 500 }
      let(:error_response) { "{invalid json" }

      before do
        stub_request(:post, "#{Seam::DEFAULT_ENDPOINT}/devices/list")
          .to_return(status: error_status, body: error_response, headers: {"Content-Type" => "application/json"})
      end

      it "raises Faraday error" do
        expect { seam.devices.list }.to raise_error(Faraday::ServerError)
      end
    end

    context "when JSON response without error object" do
      let(:error_status) { 500 }
      let(:error_response) { '{"message": "Some error"}' }

      before do
        stub_request(:post, "#{Seam::DEFAULT_ENDPOINT}/devices/list")
          .to_return(status: error_status, body: error_response, headers: {"Content-Type" => "application/json"})
      end

      it "raises Faraday error" do
        expect { seam.devices.list }.to raise_error(Faraday::ServerError)
      end
    end
  end
end
