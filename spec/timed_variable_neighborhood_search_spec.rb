require 'spec_helper'

describe TimedVariableNeighborhoodSearch do
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

  it "new instance - Dijkstra (standard)" do
    material_flow = [
      [:f1, :f4, 10],
      [:f4, :f6, 20],
      [:f6, :f3, 30],
      [:f3, :f2, 40],
      [:f2, :f5, 50],
      [:f5, :f0, 60]
    ]

    vns = TimedVariableNeighborhoodSearch.new(@facilities, material_flow)
    expect(vns.class).to eq(TimedVariableNeighborhoodSearch)

    best = vns.search(1..5,0.1,0.1)
    expect(best.class).to eq(Layout)

    initial = vns.initial_layout
    expect(initial.class).to eq(Layout)

    iter = vns.iter
    expect(iter).to be > 0
    #p iter
    #p vns.best_iter

    expect(initial.material_flow.costs).to be >= best.material_flow.costs
    #p initial.material_flow.costs
    #p best.material_flow.costs
    SVGHelper.layout_to_svg_file(initial,@output_path_pattern + 'initial_layout.svg')
    SVGHelper.layout_to_svg_file(best,@output_path_pattern + 'best_layout.svg')
  end


  it "new instance - Floyd-Warshall" do
    material_flow = [
      [:f1, :f4, 10],
      [:f4, :f6, 20],
      [:f6, :f3, 30],
      [:f3, :f2, 40],
      [:f2, :f5, 50],
      [:f5, :f0, 60]
    ]

    vns = VariableNeighborhoodSearch.new(@facilities, material_flow)
    expect(vns.class).to eq(VariableNeighborhoodSearch)

    vns.mf_klass = MaterialFlowFloyd

    best = vns.search(1..5,2,2)
    expect(best.class).to eq(Layout)

    initial = vns.initial_layout
    expect(initial.class).to eq(Layout)

    iter = vns.iter
    expect(iter).to be > 0

    expect(initial.material_flow.costs).to be >= best.material_flow.costs
    SVGHelper.layout_to_svg_file(initial,@output_path_pattern + 'initial_layout_floyd.svg')
    SVGHelper.layout_to_svg_file(best,@output_path_pattern + 'best_layout_floyd.svg')
  end
end

