require 'spec_helper'

describe MaterialFlow do
  it "4 Facilities" do
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

    100000.times do
      facilities = [f3, f2,f1, f4]
      silicing_order = [2, 0, 1]
      orientation =   [0, 1, 0]
      layout = Layout.new(facilities,silicing_order,orientation)
      mf = MaterialFlow.new(layout, material_flow)
      expect(mf.distance.round).to  eq(36)
      expect(mf.costs.round).to  eq(766)
    end
  end

end
