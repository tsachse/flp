require File.dirname(__FILE__) + '/dataset_helper'
# require 'profile'

describe VariableNeighborhoodSearch do

  it "4 Facilities" do
    f1 = Facility.new(:f1, 18, 10)
    f2 = Facility.new(:f2,  9,  5)
    f3 = Facility.new(:f3, 10, 10)
    f4 = Facility.new(:f4, 20, 15)
    facilities = [f1,f2,f3,f4]

    material_flow = [
      [:f1, :f2, 20],
      [:f1, :f3, 30],
      [:f1, :f4, 15],
      [:f2, :f3,  5],
      [:f2, :f4, 38],
      [:f3, :f4, 12]
    ]

    50.times do
      neighbours = 1..5
      max_no_improv = 50
      max_no_improv_ls = 20

      vns = DatasetHelper.run('skas_4',facilities, material_flow, neighbours, max_no_improv, max_no_improv_ls) 
      expect(vns.class).to eq(VariableNeighborhoodSearch)
    end

    20.times do
      neighbours = 1..17
      max_no_improv = 150
      max_no_improv_ls = 20

      vns = DatasetHelper.run('skas_4',facilities, material_flow, neighbours, max_no_improv, max_no_improv_ls) 
      expect(vns.class).to eq(VariableNeighborhoodSearch)
    end

    30.times do
      neighbours = 71..75
      max_no_improv = 50
      max_no_improv_ls = 20

      vns = DatasetHelper.run('skas_4',facilities, material_flow, neighbours, max_no_improv, max_no_improv_ls) 
      expect(vns.class).to eq(VariableNeighborhoodSearch)
    end

  end

end
