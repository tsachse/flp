require 'spec_helper'

describe FacilitySet do
  it "new instance" do
    f1 = Facility.new(:f1, 10, 20)
    f2 = Facility.new(:f2, 30, 30)
    f = [f1,f2]

    fs = FacilitySet.new(f)

    expect(fs.class).to eq(FacilitySet)
    expect(fs.width).to eq(40)
    expect(fs.height).to eq(50)
    expect(fs.can_cut?(:f1)).to eq(true)
    expect(fs.can_cut?(:f3)).to eq(false)
    expect(fs.cut_facilities(:f1)).to eq([[f1],[f2]])
  end

end
