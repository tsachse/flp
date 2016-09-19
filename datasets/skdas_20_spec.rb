require File.dirname(__FILE__) + '/dataset_helper'

describe VariableNeighborhoodSearch do

  it "20 Facilities" do
    f1 = Facility.new(:f1, 15, 10)
    f2 = Facility.new(:f2, 12,  8)
    f3 = Facility.new(:f3, 15, 12)
    f4 = Facility.new(:f4,  9,  9)
    f5 = Facility.new(:f5,  9,  6)
    f6 = Facility.new(:f6, 25, 18)
    f7 = Facility.new(:f7, 20, 16)
    f8 = Facility.new(:f8,  8,  5)
    f9 = Facility.new(:f9, 11, 11)
    f10 = Facility.new(:f10, 19, 13)
    f11 = Facility.new(:f11, 15, 10)
    f12 = Facility.new(:f12, 12,  8)
    f13 = Facility.new(:f13, 15, 12)
    f14 = Facility.new(:f14,  9,  9)
    f15 = Facility.new(:f15,  9,  6)
    f16 = Facility.new(:f16, 25, 18)
    f17 = Facility.new(:f17, 20, 16)
    f18 = Facility.new(:f18,  8,  5)
    f19 = Facility.new(:f19, 11, 11)
    f20 = Facility.new(:f20, 19, 13)
    		
    facilities = [f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20]

    material_flow = [
      [:f1, :f2,  10], [:f1, :f3,  35], [:f1, :f4,  18], [:f1, :f5,  25], [:f1, :f6,  45],
      [:f1, :f7,  11], [:f1, :f8,   0], [:f1, :f9,  31], [:f1, :f10, 16], [:f2, :f3,   0],
      [:f2, :f4,  10], [:f2, :f5,  18], [:f2, :f6,   0], [:f2, :f7,   4], [:f2, :f8,  11],
      [:f2, :f9,  30], [:f2, :f10,  0], [:f3, :f4,  16], [:f3, :f5,   0], [:f3, :f6,  53],
      [:f3, :f7,   0], [:f3, :f8,  30], [:f3, :f9,  61], [:f3, :f10,  8], [:f4, :f5,  18],
      [:f4, :f6,  25], [:f4, :f7,  11], [:f4, :f8,   8], [:f4, :f9,  29], [:f4, :f10, 19],
      [:f5, :f6,  63], [:f5, :f7,  30], [:f5, :f8,  16], [:f5, :f9,   0], [:f5, :f10, 21],
      [:f6, :f7,   0], [:f6, :f8,  40], [:f6, :f9,  13], [:f6, :f10, 14], [:f7, :f8,   0],
      [:f7, :f9,  17], [:f7, :f10, 79], [:f8, :f9,   0], [:f8, :f10, 11], [:f9, :f10, 35],
      [:f11, :f12,  10], [:f11, :f13,  35], [:f11, :f14,  18], [:f11, :f15,  25], [:f11, :f16,  45],
      [:f11, :f17,  11], [:f11, :f18,   0], [:f11, :f19,  31], [:f11, :f20,  16], [:f12, :f13,   0],
      [:f12, :f14,  10], [:f12, :f15,  18], [:f12, :f16,   0], [:f12, :f17,   4], [:f12, :f18,  11],
      [:f12, :f19,  30], [:f12, :f20,   0], [:f13, :f14,  16], [:f13, :f15,   0], [:f13, :f16,  53],
      [:f13, :f17,   0], [:f13, :f18,  30], [:f13, :f19,  61], [:f13, :f20,   8], [:f14, :f15,  18],
      [:f14, :f16,  25], [:f14, :f17,  11], [:f14, :f18,   8], [:f14, :f19,  29], [:f14, :f20,  19],
      [:f15, :f16,  63], [:f15, :f17,  30], [:f15, :f18,  16], [:f15, :f19,   0], [:f15, :f20,  21],
      [:f16, :f17,   0], [:f16, :f18,  40], [:f16, :f19,  13], [:f16, :f20,  14], [:f17, :f18,   0],
      [:f17, :f19,  17], [:f17, :f20, 79],  [:f18, :f19,   0], [:f18, :f20,  11], [:f19, :f20,  35],
    ]

    neighbours = 1..5
    max_no_improv = 50
    max_no_improv_ls = 20

    vns = DatasetHelper.run('skas_20',facilities, material_flow, neighbours, max_no_improv, max_no_improv_ls) 
    expect(vns.class).to eq(VariableNeighborhoodSearch)

  end

end
