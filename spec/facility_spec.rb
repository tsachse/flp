require 'spec_helper'

describe Facility do
  it "new instance" do
    f = Facility.new(:f1, 16, 4)

    expect(f.class).to eq(Facility)
    expect(f.id).to eq(:f1)
    expect(f.width).to eq(16)
    expect(f.height).to eq(4)
    expect(f.north).to eq([8, 0])
    expect(f.west).to eq([0, 2])
    expect(f.south).to eq([8, 4])
    expect(f.east).to eq([16, 2])
    expect(Facility.distance(f.east,f.west)).to eq(f.width)
    expect(Facility.distance(f.north,f.south)).to eq(f.height)
    d1 = Facility.distance(f.north,f.east)
    d2 = Facility.distance(f.north,f.west)
    expect(d1).to eq(d2)
  end

end
