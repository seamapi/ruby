# frozen_string_literal: true

RSpec.describe Seam::Clients::AccessCodesUnmanaged do
  let(:client) { Seam::Client.new(api_key: "seam_some_api_key") }

  describe "#get" do
    let(:access_code_id) { "123" }
    let(:unmanaged_access_code_hash) { {access_code_id: access_code_id} }

    before do
      stub_seam_request(
        :post, "/access_codes/unmanaged/get", {access_code: unmanaged_access_code_hash}
      ).with { |req| req.body.source == {access_code_id: access_code_id}.to_json }
    end

    let(:result) { client.unmanaged_access_codes.get(access_code_id: access_code_id) }

    it "returns an unmanaged Access Code" do
      expect(result).to be_a(Seam::UnmanagedAccessCode)
    end
  end

  describe "#list" do
    let(:device_id) { "456" }
    let(:unmanaged_access_code_hash) { {access_code_id: "123", device_id: device_id} }

    before do
      stub_seam_request(:post, "/access_codes/unmanaged/list",
        {access_codes: [unmanaged_access_code_hash]}).with do |req|
        req.body.source == {device_id: device_id}.to_json
      end
    end

    let(:unmanaged_access_codes) { client.unmanaged_access_codes.list(device_id: device_id) }

    it "returns a list of unmanaged Access Codes" do
      expect(unmanaged_access_codes).to be_a(Array)
      expect(unmanaged_access_codes.first).to be_a(Seam::UnmanagedAccessCode)
      expect(unmanaged_access_codes.first.access_code_id).to be_a(String)
    end
  end

  describe "#convert_to_managed" do
    let(:access_code_id) { "access_code_1234" }
    let(:action_attempt_hash) { {action_attempt_id: "1234", status: "pending"} }

    before do
      stub_seam_request(
        :post, "/access_codes/unmanaged/convert_to_managed", {action_attempt: action_attempt_hash}
      ).with do |req|
        req.body.source == {access_code_id: access_code_id}.to_json
      end

      stub_seam_request(
        :post,
        "/action_attempts/get",
        nil
      ).with { |req| req.body.source == {action_attempt_id: action_attempt_hash[:action_attempt_id]}.to_json }
    end

    let(:result) { client.unmanaged_access_codes.convert_to_managed(access_code_id: access_code_id) }

    it "returns an Action Attempt" do
      expect(result).to be_a(NilClass)
    end
  end

  describe "#delete" do
    let(:access_code_id) { "access_code_5678" }
    let(:action_attempt_hash) { {action_attempt_id: "5678", status: "pending"} }

    before do
      stub_seam_request(
        :post, "/access_codes/unmanaged/delete", {action_attempt: action_attempt_hash}
      ).with do |req|
        req.body.source == {access_code_id: access_code_id}.to_json
      end

      stub_seam_request(
        :post,
        "/action_attempts/get",
        nil
      ).with { |req| req.body.source == {action_attempt_id: action_attempt_hash[:action_attempt_id]}.to_json }
    end

    let(:result) { client.unmanaged_access_codes.delete(access_code_id: access_code_id) }

    it "returns an Action Attempt" do
      expect(result).to be_a(NilClass)
    end
  end
end
