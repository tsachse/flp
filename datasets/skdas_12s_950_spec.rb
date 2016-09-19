require File.dirname(__FILE__) + '/dataset_helper'

describe VariableNeighborhoodSearch do

  it "12 Facilities" do
    f1  = Facility.new(:f1,   9,  7)
    f2  = Facility.new(:f2,  14, 10)
    f3  = Facility.new(:f3,  12, 10)
    f4  = Facility.new(:f4,   8,  8)
    f5  = Facility.new(:f5,  12, 12)
    f6  = Facility.new(:f6,  10,  8)
    f7  = Facility.new(:f7,  20, 14)
    f8  = Facility.new(:f8,  15, 11)
    f9  = Facility.new(:f9,  12,  9)
    f10 = Facility.new(:f10, 10, 10)
    f11 = Facility.new(:f11, 11, 11)
    f12 = Facility.new(:f12, 12,  8)
    							
    		
    facilities = [f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12]

    material_flow = [
      [:f1, :f2,   31], [:f1, :f3,   14], [:f1, :f4,   38], [:f1, :f5,   19],
      [:f1, :f6,   11], [:f1, :f7,   15], [:f1, :f8,   12], [:f1, :f9,   10],
      [:f1, :f10,  18], [:f1, :f11,  26], [:f1, :f12,  50], [:f2, :f3,   60],
      [:f2, :f4,   17], [:f2, :f5,   17], [:f2, :f6,   40], [:f2, :f7,   33],
      [:f2, :f8,   12], [:f2, :f9,   17], [:f2, :f10,   0], [:f2, :f11,  14],
      [:f2, :f12,  17], [:f3, :f4,   61], [:f3, :f5,   70], [:f3, :f6,   18],
      [:f3, :f7,   42], [:f3, :f8,   13], [:f3, :f9,   21], [:f3, :f10,  25],
      [:f3, :f11,  35], [:f3, :f12,  43], [:f4, :f5,   50], [:f5, :f6,   10],
      [:f5, :f7,   12], [:f5, :f8,   60], [:f5, :f9,   63], [:f5, :f10,  18],
      [:f5, :f11,  51], [:f5, :f12,  15], [:f6, :f7,   19], [:f6, :f8,   17],
      [:f6, :f9,   49], [:f6, :f10,  53], [:f6, :f11,  25], [:f6, :f12,  22],
      [:f7, :f8,   11], [:f7, :f9,   13], [:f7, :f10,  26], [:f7, :f11,  39],
      [:f7, :f12,  52], [:f8, :f9,   13], [:f8, :f10,  28], [:f8, :f11,  42],
      [:f8, :f12,  17], [:f9, :f10,  15], [:f9, :f11,  14], [:f9, :f12,  12],
      [:f10, :f11, 17], [:f10, :f12, 31], [:f11, :f12, 19],
    ]

    neighbours = 1..23
    max_no_improv = 200
    max_no_improv_ls = 50

    950.times do
      vns = DatasetHelper.run('skas_12s_950',facilities, material_flow, neighbours, 
			      max_no_improv, max_no_improv_ls, MaterialFlowSimple) 
      expect(vns.class).to eq(VariableNeighborhoodSearch)
    end

  end

end
