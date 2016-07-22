require 'spec_helper'

describe MaterialFlowFloyd do
  before(:each) do
    f0 = Facility.new(:f0, 100, 200)
    f1 = Facility.new(:f1, 100, 200)
    f2 = Facility.new(:f2, 300, 200)
    f3 = Facility.new(:f3, 300, 200)
    f4 = Facility.new(:f4, 300, 300)
    f5 = Facility.new(:f5, 100, 500)
    f6 = Facility.new(:f6, 300, 100)
    @facilities = [f2,f6,f3,f4,f5,f0,f1]
    @output_path_pattern = File.dirname(__FILE__) + '/output/mhc_'
  end

  it "new instance" do
    silicing_order = [4,3,2,1,0,5]
    orientation =    [0,0,1,1,1,0]
    layout = Layout.new(@facilities,silicing_order,orientation)
    material_flow = [
      [:f1, :f4, 10],
      [:f4, :f6, 20],
      [:f6, :f3, 30],
      [:f3, :f2, 40],
      [:f2, :f5, 50],
      [:f5, :f0, 60]
    ]

    expect(layout.class).to eq(Layout)
    expect(layout.facility_set_ids).to eq([[:f2], [:f6], [:f3], [:f4], [:f5], [:f0], [:f1]])
    mf = MaterialFlowFloyd.new(layout, material_flow)
    edges = mf.direct_mf_connections
    expect(edges).to include(["f1_e", "f4_n", 1241.974234837422]) 
    mf.find_feeding
    #expect(mf.facility_map[:f0].feeding).to eq(:s)
    #expect(mf.facility_map[:f5].feeding).to eq(:n)
    mf.calculate_costs
    #expect(mf.costs).to be > mf.distance
    #expect(mf.costs).to eq(layout.material_flow.costs)

    #expect(mhc.class).to eq(MaterialHandlingCosts)
    #edges =  mhc.material_flow_edges
    #d = mhc.material_flow_distance
    #flow =  mhc.material_flow_path
    #p d
    #p mhc.material_flow_path
    #DotHelper.edges_to_dot_file(edges, flow, @output_path_pattern + 'new_instance.dot')

  end

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

    facilities = [f3, f2,f1, f4]
    silicing_order = [2, 0, 1]
    orientation =   [0, 1, 0]
    layout = Layout.new(facilities,silicing_order,orientation)
    mf = MaterialFlowFloyd.new(layout, material_flow)
    # expect(mf.distance.round).to  eq(34)
    # expect(mf.costs.round).to  eq(728)
    # p '----'
    # p mf.distance.round
    # p mf.costs.round
    #p FloydWarshall.show mf.layout_graph.short
    #p 'x'
    #p FloydWarshall.show mf.layout_graph.matrix
  end

end
