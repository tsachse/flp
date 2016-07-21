require File.dirname(__FILE__) + '/dataset_helper'

describe VariableNeighborhoodSearch do

  it "10 Facilities" do
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
    		
    facilities = [f1,f2,f3,f4,f5,f6,f7,f8,f9,f10]

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
    ]

    neighbours = 1..5
    max_no_improv = 50
    max_no_improv_ls = 20

    vns = DatasetHelper.run('skas_10',facilities, material_flow, neighbours, max_no_improv, max_no_improv_ls) 
    expect(vns.class).to eq(VariableNeighborhoodSearch)

  end

end
