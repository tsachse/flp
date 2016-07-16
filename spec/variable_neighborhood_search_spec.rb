require 'spec_helper'

describe VariableNeighborhoodSearch do
  before(:each) do
    f0 = Facility.new(:f0, 100, 200)
    f1 = Facility.new(:f1, 100, 200)
    f2 = Facility.new(:f2, 300, 200)
    f3 = Facility.new(:f3, 300, 200)
    f4 = Facility.new(:f4, 300, 300)
    f5 = Facility.new(:f5, 100, 500)
    f6 = Facility.new(:f6, 300, 100)
    @facilities = [f0,f1,f2,f3,f4,f5,f6]
    @output_path_pattern = File.dirname(__FILE__) + '/output/vns_'
  end

  it "new instance" do
    vns = VariableNeighborhoodSearch.new(@facilities)
    expect(vns.class).to eq(VariableNeighborhoodSearch)

    best = vns.search(1..20,10,10)
    expect(best.class).to eq(Layout)

    initial = vns.initial_layout
    expect(initial.class).to eq(Layout)

    iter = vns.iter
    expect(iter).to be > 0
    p iter
    p vns.best_iter

    expect(initial.mhc.distance).to be > best.mhc.distance
    p initial.mhc.distance
    p best.mhc.distance
    SVGHelper.layout_to_svg_file(initial,@output_path_pattern + 'initial_layout.svg')
    SVGHelper.layout_to_svg_file(best,@output_path_pattern + 'best_layout.svg')
  end
end

