# frozen_string_literal: true

RSpec.describe "at least one parameter guards", recorder: true do
  def rejected_for(path)
    raise_error(TypeError, "At least one parameter is required for #{path}")
  end

  before { recorder.respond_with({access_methods: [], events: [], pagination: {has_next_page: false}}.to_json) }

  it "rejects a call that names only a limit" do
    expect { seam.access_methods.list(limit: 10) }.to rejected_for("/access_methods/list")
    expect(recorder.requests).to be_empty
  end

  it "rejects a call that names only a page cursor" do
    expect { seam.access_methods.list(page_cursor: "cursor-1") }.to rejected_for("/access_methods/list")
    expect(recorder.requests).to be_empty
  end

  it "accepts a call that names a filter alongside pagination params" do
    seam.access_methods.list(device_id: "device-1", limit: 10)

    expect(recorder.requests.map(&:path)).to eq(["/access_methods/list"])
  end

  it "still guards an unpaginated route" do
    expect { seam.events.list(limit: 20) }.to rejected_for("/events/list")
    expect(recorder.requests).to be_empty
  end

  it "rejects a paginator over an unfiltered list" do
    paginator = seam.create_paginator(seam.access_methods.method(:list), {limit: 10})

    expect { paginator.first_page }.to rejected_for("/access_methods/list")
    expect { paginator.next_page("cursor-1") }.to rejected_for("/access_methods/list")
    expect(recorder.requests).to be_empty
  end

  it "accepts a paginator over a filtered list" do
    paginator = seam.create_paginator(seam.access_methods.method(:list), {device_id: "device-1"})

    paginator.first_page

    expect(recorder.requests.map(&:path)).to eq(["/access_methods/list"])
  end
end
