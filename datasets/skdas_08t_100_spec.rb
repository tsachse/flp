require File.dirname(__FILE__) + '/dataset_helper'

describe TimedVariableNeighborhoodSearch do

  it "8 Facilities" do
    f1 = Facility.new(:f1, 14, 10)
    f2 = Facility.new(:f2, 10,  7)
    f3 = Facility.new(:f3, 10, 10)
    f4 = Facility.new(:f4, 20, 15)
    f5 = Facility.new(:f5, 18, 13)
    f6 = Facility.new(:f6,  8,  8)
    f7 = Facility.new(:f7,  9,  6)
    f8 = Facility.new(:f8, 15, 11)
    facilities = [f1,f2,f3,f4,f5,f6,f7,f8]

    material_flow = [
      [:f1, :f2, 30],
      [:f1, :f3, 12],
      [:f1, :f4, 16],
      [:f1, :f5, 15],
      [:f1, :f6,  0],
      [:f1, :f7,  4],
      [:f1, :f8, 11],
      [:f2, :f3,  6],
      [:f2, :f4,  0],
      [:f2, :f5,  4],
      [:f2, :f6,  3],
      [:f2, :f7,  0],
      [:f2, :f8,  0],
      [:f3, :f4, 30],
      [:f3, :f5, 16],
      [:f3, :f6, 85],
      [:f3, :f7,  0],
      [:f3, :f8, 31],
      [:f4, :f5, 26],
      [:f4, :f6, 60],
      [:f4, :f7, 34],
      [:f4, :f8, 18],
      [:f5, :f6, 30],
      [:f5, :f7, 24],
      [:f5, :f8, 45],
      [:f6, :f7, 41],
      [:f6, :f8, 19],
      [:f7, :f8, 48],
    ]

    100.times do
      neighbours = 1..17
      max_duration = 25
      max_duration_ls = 2

      vns = DatasetHelper.timed_run('skas_8t',facilities, material_flow, neighbours, max_duration, max_duration_ls) 
      expect(vns.class).to eq(TimedVariableNeighborhoodSearch)
    end

  end

end
