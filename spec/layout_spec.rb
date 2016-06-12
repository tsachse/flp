require 'spec_helper'

describe Layout do
  it "new instance" do
    facilities = [2,6,3,4,5,0,1]
    silicing_order = [4,3,2,1,0,5]
    orientation = [0,0,1,1,0]
    l = Layout.new(facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    expect(l.facility_set).to eq([[2], [6], [3], [4], [5], [0], [1]])
  end

  it "a horizontal cut" do
    facilities = [2,6,3,4,5,0,1]
    silicing_order = [4]
    orientation = [0]
    l = Layout.new(facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    expect(l.facility_set).to eq([[2, 6, 3, 4, 5], [0, 1]])
  end

  it "a vertical cut" do
    facilities = [2,6,3,4,5,0,1]
    silicing_order = [4]
    orientation = [1]
    l = Layout.new(facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    expect(l.facility_set).to eq([[2, 6, 3, 4, 5], [0, 1]])
  end
end
