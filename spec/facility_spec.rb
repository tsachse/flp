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
  
  it "detects line intersection using Liang-Barsky" do
    # trivial rect
    rect = Facility.new(:f1, 25, 25)
    rect.x1 = 50
    rect.y1 = 50
    rect.x2 = 75
    rect.y2 = 75
    expect(rect.intersects_line?(25, 25, 85, 85)).to eq(true)
    expect(rect.intersects_line?(95, 95, 150, 175)).to eq(false)
    expect(rect.intersects_line?(25, 25, 60, 60)).to eq(true)
    
    # non-trivial clipping
    rect = Facility.new(:f2, 150, 90)
    rect.x1 = 75
    rect.y1 = 80
    rect.x2 = 225
    rect.y2 = 170
    #expect(rect.intersects_line?(50, 50, 80, 80)).to eq(true)
    expect(rect.intersects_line?(76, 81, 90, 90)).to eq(true)
    expect(rect.intersects_line?(90, 90, 250, 250)).to eq(true)
    expect(rect.intersects_line?(200, 200, 250, 250)).to eq(false)
    expect(rect.intersects_line?(300, 80, 300, 125)).to eq(false)
  end
  
end
