# frozen_string_literal: true

RSpec.describe Seam::Clients::ConnectedAccounts do
  let(:client) { Seam::Client.new(api_key: "seam_some_api_key") }
  let(:connected_account_id) { "connected_account_id_1234" }

  describe "#get" do
    let(:connected_account_hash) { {connected_account_id: connected_account_id} }

    context "with connected_account_id" do
      before do
        stub_seam_request(
          :post, "/connected_accounts/get", {connected_account: connected_account_hash}
        ).with { |req| req.body.source == {connected_account_id: connected_account_id}.to_json }
      end

      let(:result) { client.connected_accounts.get(connected_account_id: connected_account_id) }

      it "returns a ConnectedAccount" do
        expect(result).to be_a(Seam::ConnectedAccount)
      end
    end

    context "with email" do
      let(:email) { "jane@example.com" }

      before do
        stub_seam_request(
          :post, "/connected_accounts/get", {connected_account: connected_account_hash}
        ).with { |req| req.body.source == {email: email}.to_json }
      end

      let(:result) { client.connected_accounts.get(email: email) }

      it "returns a ConnectedAccount" do
        expect(result).to be_a(Seam::ConnectedAccount)
      end
    end

    context "with errors and warnings" do
      let(:account_disconnected_error) { {error_code: "account_disconnected", message: "Account was disconnected"} }
      let(:limit_reached_warning) { {warning_code: "limit_reached", message: "Account reached its limit"} }

      before do
        stub_seam_request(
          :post, "/connected_accounts/get", {connected_account: connected_account_hash.merge(
            errors: [account_disconnected_error],
            warnings: [limit_reached_warning]
          )}
        ).with { |req| req.body.source == {connected_account_id: connected_account_id}.to_json }
      end

      let(:result) { client.connected_accounts.get(connected_account_id: connected_account_id) }

      it "returns errors on connected account" do
        expect(result.errors.first.error_code).to eq("account_disconnected")
      end

      it "returns warnings on connected account" do
        expect(result.warnings.first.warning_code).to eq("limit_reached")
      end
    end
  end

  describe "#list" do
    let(:connected_account_hash) { {connected_account_id: connected_account_id} }

    before do
      stub_seam_request(
        :post, "/connected_accounts/list", {connected_accounts: [connected_account_hash]}
      )
    end

    let(:result) { client.connected_accounts.list }

    it "returns a ConnectedAccount Array" do
      expect(result).to be_a(Array)
      expect(result.first).to be_a(Seam::ConnectedAccount)
    end
  end
end
