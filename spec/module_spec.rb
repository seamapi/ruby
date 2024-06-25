# frozen_string_literal: true

RSpec.describe Seam do
  it "has a version number" do
    expect(Seam::VERSION).not_to be nil
  end

  it "has a LTS version number" do
    expect(Seam::LTS_VERSION).not_to be nil
  end
end
