# frozen_string_literal: true

RSpec.describe Seam::Resources::AcsCredential do
  let(:client) { Seam.new(api_key: "seam_some_api_key") }

  describe "date handling" do
    context "with nil dates" do
      let(:credential_hash) do
        {
          acs_credential_id: "test_id",
          issued_at: nil,
          created_at: nil
        }
      end

      it "returns nil for nil date fields" do
        credential = described_class.new(credential_hash, client)
        expect(credential.issued_at).to be_nil
        expect(credential.created_at).to be_nil
      end
    end

    context "with valid dates" do
      let(:now) { Time.now.utc }
      let(:credential_hash) do
        {
          acs_credential_id: "test_id",
          issued_at: now.iso8601,
          created_at: now.iso8601
        }
      end

      it "parses date fields correctly" do
        credential = described_class.new(credential_hash, client)
        expect(credential.issued_at).to be_a(Time)
        expect(credential.created_at).to be_a(Time)
      end
    end
  end
end
