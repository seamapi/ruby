# frozen_string_literal: true

RSpec.describe Seam::Http do
  let(:client) { Seam.new(api_key: "seam_some_api_key") }

  describe "Exceptions" do
    describe "400" do
      let(:request_id) { "request_id_1234" }
      let(:message) { "Some Error Message" }
      let(:type) { "Some Error Type" }
      let(:error) { {type: type, message: message} }

      before do
        stub_seam_request(
          :get,
          "/health",
          {error: error},
          status: 400,
          headers: {"seam-request-id" => request_id}
        )
      end

      it "parses the error" do
        expect { client.health }.to raise_error do |error|
          expect(error).to be_a(Seam::Http::HttpApiError)
          expect(error.message).to eq(message)
          expect(error.code).to eq(type)
          expect(error.request_id).to eq(request_id)
        end
      end
    end

    describe "409" do
      let(:request_id) { "request_id_1234" }
      let(:message) { "Some Error Message" }
      let(:type) { "Some Error Type" }
      let(:error) { {type: type, message: message} }

      before do
        stub_seam_request(
          :get,
          "/health",
          {error: error},
          status: 409,
          headers: {"seam-request-id" => request_id}
        )
      end

      it "parses the error" do
        expect { client.health }.to raise_error do |error|
          expect(error).to be_a(Seam::Http::HttpApiError)
          expect(error.message).to eq(message)
          expect(error.code).to eq(type)
          expect(error.request_id).to eq(request_id)
        end
      end
    end
  end
end
