require 'spec_helper'

describe Layout do
  it "new instance" do
    f0 = Facility.new(:f0, 10, 20)
    f1 = Facility.new(:f1, 30, 30)
    f2 = Facility.new(:f2, 30, 30)
    f3 = Facility.new(:f3, 30, 30)
    f4 = Facility.new(:f4, 30, 30)
    f5 = Facility.new(:f5, 30, 30)
    f6 = Facility.new(:f6, 30, 30)
    facilities = [f2,f6,f3,f4,f5,f0,f1]
    silicing_order = [4,3,2,1,0,5]
    orientation = [0,0,1,1,0]
    l = Layout.new(facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    #expect(l.facility_set).to eq([[2], [6], [3], [4], [5], [0], [1]])
  end

#  it "a horizontal cut" do
#    facilities = [2,6,3,4,5,0,1]
#    silicing_order = [4]
#    orientation = [0]
#    l = Layout.new(facilities,silicing_order,orientation)
#
#    expect(l.class).to eq(Layout)
#    expect(l.facility_set).to eq([[2, 6, 3, 4, 5], [0, 1]])
#  end

#  it "a vertical cut" do
#    facilities = [2,6,3,4,5,0,1]
#    silicing_order = [4]
#    orientation = [1]
#    l = Layout.new(facilities,silicing_order,orientation)
#
#    expect(l.class).to eq(Layout)
#    expect(l.facility_set).to eq([[2, 6, 3, 4, 5], [0, 1]])
#  end
end
