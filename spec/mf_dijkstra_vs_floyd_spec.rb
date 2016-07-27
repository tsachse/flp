require 'spec_helper'

describe MaterialFlow do

  it "Dijkstra vs. Floyd" do
    f1 = Facility.new(:f1, 18, 10)
    f2 = Facility.new(:f2,  9,  5)
    f3 = Facility.new(:f3, 10, 10)
    f4 = Facility.new(:f4, 20, 15)

    material_flow = [
      [:f1, :f2, 20],
      [:f1, :f3, 30],
      [:f1, :f4, 15],
      [:f2, :f3,  5],
      [:f2, :f4, 38],
      [:f3, :f4, 12]
    ]

    facilities = [f3, f2,f1, f4]
    silicing_order = [2, 0, 1]
    orientation =   [0, 1, 0]
    layout = Layout.new(facilities,silicing_order,orientation)
    mf = MaterialFlow.new(layout, material_flow)
    d1 = mf.distance.round
    c1 = mf.costs.round

    mf = MaterialFlowFloyd.new(layout, material_flow)
    expect(mf.distance.round).to  eq(d1)
    expect(mf.costs.round).to  eq(c1)
  end

end
