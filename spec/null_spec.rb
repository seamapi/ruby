# frozen_string_literal: true

RSpec.describe Seam::NULL do
  it "is the single instance of Seam::Null" do
    expect(described_class).to be_a(Seam::Null)
    expect(described_class).to equal(Seam::Null.instance)
  end

  it "cannot be constructed a second time" do
    expect { Seam::Null.new }.to raise_error(NoMethodError)
  end

  it "is detected by type rather than identity" do
    expect(described_class.is_a?(Seam::Null)).to be true
  end

  it "reads as its own name in error messages and debuggers" do
    expect(described_class.to_s).to eq("NULL")
    expect(described_class.inspect).to eq("NULL")
  end

  it "is not nil, so Hash#compact keeps it" do
    expect({name: described_class}.compact).to eq({name: described_class})
  end
end
