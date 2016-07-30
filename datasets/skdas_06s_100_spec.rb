require File.dirname(__FILE__) + '/dataset_helper'

describe VariableNeighborhoodSearch do

  it "6 Facilities" do
    100.times do
      f1 = Facility.new(:f1,10,8)
      f2 = Facility.new(:f2,20,15)
      f3 = Facility.new(:f3,12,10)
      f4 = Facility.new(:f4,12,8)
      f5 = Facility.new(:f5,8,8)
      f6 = Facility.new(:f6,9,6)
												  
      facilities = [f1,f2,f3,f4,f5,f6]

      material_flow = [
	[:f1, :f2, 50],
	[:f1, :f3,  0],
	[:f1, :f4, 15],
	[:f1, :f5, 16],
	[:f1, :f6,  4],
	[:f2, :f3, 28],
	[:f2, :f4, 11],
	[:f2, :f5,  6],
	[:f2, :f6,  0],
	[:f3, :f4, 45],
	[:f3, :f5,  0],
	[:f3, :f6, 10],
	[:f4, :f5,  0],
	[:f4, :f6, 15],
	[:f5, :f6, 12]
      ]

      neighbours = 1..17
      max_no_improv = 100
      max_no_improv_ls = 30

      vns = DatasetHelper.run('skas_6s',facilities, material_flow, neighbours, 
			      max_no_improv, max_no_improv_ls, MaterialFlowSimple) 
      expect(vns.class).to eq(VariableNeighborhoodSearch)
    end

  end

end
