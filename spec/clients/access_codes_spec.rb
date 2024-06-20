# frozen_string_literal: true

RSpec.describe Seam::Clients::AccessCodes do
  let(:client) { Seam::Client.new(api_key: "seam_some_api_key") }

  describe "#list" do
    let(:access_code_id) { "123" }
    let(:access_code_hash) { {access_code_id: access_code_id} }

    context "'device_id' param" do
      let(:device_id) { "device_id_1234" }

      before do
        stub_seam_request(:post, "/access_codes/list",
          {access_codes: [access_code_hash]}).with do |req|
          req.body.source == {device_id: device_id}.to_json
        end
      end

      let(:access_codes) { client.access_codes.list(device_id: device_id) }

      it "returns a list of Access codes" do
        expect(access_codes).to be_a(Array)
        expect(access_codes.first).to be_a(Seam::AccessCode)
        expect(access_codes.first.access_code_id).to be_a(String)
      end
    end

    context "'access_code_ids' param" do
      before do
        stub_seam_request(:post, "/access_codes/list",
          {access_codes: [access_code_hash]}).with do |req|
          req.body.source == {access_code_ids: [access_code_id]}.to_json
        end
      end

      let(:access_codes) { client.access_codes.list(access_code_ids: [access_code_id]) }

      it "returns a list of Access codes" do
        expect(access_codes).to be_a(Array)
        expect(access_codes.first).to be_a(Seam::AccessCode)
        expect(access_codes.first.access_code_id).to be_a(String)
      end
    end
  end

  describe "#get" do
    let(:access_code_id) { "access_code_id_1234" }
    let(:access_code_hash) { {access_code_id: access_code_id} }
    let(:delay_in_setting_warning) do
      {warning_code: "delay_in_setting_on_device", message: "Delay in setting access code"}
    end
    let(:failed_to_set_error) { {error_code: "failed_to_set_on_device", message: "Failed to set access code"} }

    before do
      stub_seam_request(
        :post, "/access_codes/get", {access_code: access_code_hash.merge(
          errors: [failed_to_set_error],
          warnings: [delay_in_setting_warning]
        )}
      ).with { |req| req.body.source == {access_code_id: access_code_id}.to_json }
    end

    let(:result) { client.access_codes.get(access_code_id: access_code_id) }

    it "returns an Access Code" do
      expect(result).to be_a(Seam::AccessCode)
    end

    it "returns access code errors" do
      expect(result.errors.first.error_code).to eq("failed_to_set_on_device")
    end

    it "returns access code warnings" do
      expect(result.warnings.first.warning_code).to eq("delay_in_setting_on_device")
    end
  end

  describe "#create" do
    let(:access_code_hash) { {device_id: "1234", name: "A C", code: 1234} }

    before do
      stub_seam_request(
        :post, "/access_codes/create", {access_code: access_code_hash}
      )
    end

    let(:result) { client.access_codes.create(**access_code_hash) }

    it "returns an Access Code" do
      expect(result).to be_a(Seam::AccessCode)
    end
  end

  describe "#delete" do
    let(:access_code_id) { "access_code_1234" }
    let(:action_attempt_hash) { {action_attempt_id: "1234", status: "pending"} }

    before do
      stub_seam_request(
        :post, "/access_codes/delete", {action_attempt: action_attempt_hash}
      ).with do |req|
        req.body.source == {access_code_id: access_code_id}.to_json
      end

      stub_seam_request(
        :post,
        "/action_attempts/get",
        {
          action_attempt: {
            status: "success"
          }
        }
      ).with { |req| req.body.source == {action_attempt_id: action_attempt_hash[:action_attempt_id]}.to_json }
    end

    let(:result) { client.access_codes.delete(access_code_id: access_code_id) }

    it "returns an Access Code" do
      expect(result).to be_a(NilClass)
    end
  end

  describe "#update" do
    let(:access_code_id) { "access_code_1234" }
    let(:action_attempt_hash) { {action_attempt_id: "1234", status: "pending"} }

    before do
      stub_seam_request(
        :post, "/access_codes/update", {action_attempt: action_attempt_hash}
      ).with do |req|
        req.body.source == {access_code_id: access_code_id, type: "ongoing"}.to_json
      end

      stub_seam_request(
        :post,
        "/action_attempts/get",
        {
          action_attempt: {
            status: "success"
          }
        }
      ).with { |req| req.body.source == {action_attempt_id: action_attempt_hash[:action_attempt_id]}.to_json }
    end

    let(:result) { client.access_codes.update(access_code_id: access_code_id, type: "ongoing") }

    it "returns an Access Code" do
      expect(result).to be_a(NilClass)
    end
  end

  describe "#pull_backup_access_code" do
    let(:access_code_id) { "access_code_id_1234" }
    let(:access_code_hash) { {access_code_id: access_code_id, is_backup: true} }

    before do
      stub_seam_request(
        :post, "/access_codes/pull_backup_access_code", {backup_access_code: access_code_hash}
      ).with do |req|
        req.body.source == {access_code_id: access_code_id}.to_json
      end
    end

    let(:result) { client.access_codes.pull_backup_access_code(access_code_id: access_code_id) }

    it "returns an backup Access Code" do
      expect(result).to be_a(Seam::AccessCode)
    end
  end
end
