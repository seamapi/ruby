# frozen_string_literal: true

RSpec.describe Seam::Http::Request, recorder: true do
  describe "query params" do
    it "serializes arrays by repeating the name, preserving order" do
      seam.client.get("/devices/list", {device_ids: %w[device-2 device-1]})

      expect(recorder.requests.first.query).to eq("device_ids=device-2&device_ids=device-1&_strict=true")
    end

    it "serializes an empty array as a single pair with an empty value" do
      seam.client.get("/devices/list", {device_ids: []})

      expect(recorder.requests.first.query).to eq("device_ids=&_strict=true")
    end

    it "serializes nested objects by joining keys with dots" do
      seam.client.get("/devices/list", {custom_metadata_has: {internal_account_id: "user-1"}})

      expect(recorder.requests.first.query).to eq("custom_metadata_has.internal_account_id=user-1&_strict=true")
    end

    it "encodes with the WHATWG form serializer, escaping ~ and passing * through" do
      seam.client.get("/devices/list", {search: "a *~ b"})

      expect(recorder.requests.first.query).to eq("search=a+*%7E+b&_strict=true")
    end

    it "sorts pairs by name" do
      seam.client.get("/devices/list", {limit: 5, device_type: "august_lock", search: "x"})

      expect(recorder.requests.first.query).to eq("device_type=august_lock&limit=5&search=x&_strict=true")
    end

    it "omits nil params entirely" do
      seam.client.get("/devices/list", {search: nil, limit: 1})

      expect(recorder.requests.first.query).to eq("limit=1&_strict=true")
    end

    it "serializes the NULL sentinel as an empty value" do
      seam.client.get("/devices/list", {search: Seam::NULL})

      expect(recorder.requests.first.query).to eq("search=&_strict=true")
    end

    it "emits no bare ? when nothing serializes" do
      seam.client.get("/devices/list", {search: nil})
      seam.client.get("/devices/list")

      expect(recorder.requests.map(&:target)).to eq(["/devices/list", "/devices/list"])
    end

    it "emits the serialized query verbatim through base URL resolution" do
      seam.client.get("/devices/list", {device_ids: [], search: "a *~ b"})

      expect(recorder.requests.first.target).to eq("/devices/list?device_ids=&search=a+*%7E+b&_strict=true")
    end

    it "passes a query string already built by the caller through verbatim" do
      seam.client.get("/devices/list?already=built&ids=")

      expect(recorder.requests.first.query).to eq("already=built&ids=")
    end

    it "merges params into a query string already built by the caller" do
      seam.client.get("/devices/list?built=1", {added: "a b"})

      expect(recorder.requests.first.query).to eq("added=a+b&built=1&_strict=true")
    end

    it "raises the typed error before any request is sent" do
      expect {
        seam.client.get("/devices/list", {device_ids: ["a", ""]})
      }.to raise_error(Seam::UnserializableParamError) do |error|
        expect(error.param_name).to eq("device_ids")
      end

      expect(recorder.requests).to be_empty
    end

    it "serializes query params on DELETE requests" do
      seam.client.delete("/acs/access_groups/delete", {acs_access_group_id: "group-1"})

      request = recorder.requests.first
      expect(request.method).to eq("DELETE")
      expect(request.query).to eq("acs_access_group_id=group-1&_strict=true")
    end
  end

  describe "request bodies" do
    it "sends the NULL sentinel as JSON null on POST" do
      seam.client.post("/thermostats/update", {device_id: "device-1", default_climate_setting: Seam::NULL})

      request = recorder.requests.first
      expect(request.method).to eq("POST")
      expect(JSON.parse(request.body)).to eq(
        "device_id" => "device-1",
        "default_climate_setting" => nil
      )
    end

    it "replaces the sentinel in nested hashes and arrays" do
      seam.client.post("/x", {a: {b: Seam::NULL}, c: [Seam::NULL, 1]})

      expect(JSON.parse(recorder.requests.first.body)).to eq(
        "a" => {"b" => nil},
        "c" => [nil, 1]
      )
    end

    it "does not mutate the caller's payload" do
      payload = {device_id: "device-1", name: Seam::NULL}
      seam.client.post("/x", payload)

      expect(payload[:name]).to equal(Seam::NULL)
    end

    it "sends the sentinel as JSON null on PUT and PATCH" do
      seam.client.put("/x", {name: Seam::NULL})
      seam.client.patch("/x", {name: Seam::NULL})

      expect(recorder.requests.map(&:method)).to eq(%w[PUT PATCH])
      recorder.requests.each do |request|
        expect(JSON.parse(request.body)).to eq("name" => nil)
      end
    end
  end

  describe "generated routes" do
    it "serializes a generated GET route end to end" do
      recorder.respond_with({device: {device_id: "device-1"}}.to_json)

      device = seam.locks.get(device_id: "device-1")

      request = recorder.requests.first
      expect(request.method).to eq("GET")
      expect(request.target).to eq("/locks/get?device_id=device-1&_strict=true")
      expect(device.device_id).to eq("device-1")
    end

    it "omits absent optional params from a generated route" do
      recorder.respond_with({device: {device_id: "device-1"}}.to_json)

      seam.locks.get(device_id: "device-1", name: nil)

      expect(recorder.requests.first.target).to eq("/locks/get?device_id=device-1&_strict=true")
    end
  end
end
