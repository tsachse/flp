require 'spec_helper'

describe FacilitySet do
  it "new instance" do
    f = []
    f << Facility.new(:f1, 10, 20)
    f << Facility.new(:f2, 30, 30)

    fs = FacilitySet.new(f)

    expect(fs.class).to eq(FacilitySet)
    expect(fs.width).to eq(40)
    expect(fs.height).to eq(50)
    expect(fs.size).to eq(2)
    expect(fs.grep(f[1])[0]).to eq(f[1])
  end

end
