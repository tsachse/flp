require 'spec_helper'

describe Facility do
  it "new instance" do
    f = Facility.new(:f1, 16, 4)

    expect(f.class).to eq(Facility)
    expect(f.id).to eq(:f1)
    expect(f.width).to eq(16)
    expect(f.height).to eq(4)
  end

end
