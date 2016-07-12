require 'spec_helper'

describe Layout do
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
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    expect(l.facility_set_ids).to eq([[:f2], [:f6], [:f3], [:f4], [:f5], [:f0], [:f1]])
    mhc = MaterialHandlingCosts.new(l)
    expect(mhc.class).to eq(MaterialHandlingCosts)
    edges =  mhc.material_flow_edges
    d = mhc.material_flow_distance
    flow =  mhc.material_flow_path
    p d
    p mhc.material_flow_path
    DotHelper.edges_to_dot_file(edges, flow, @output_path_pattern + 'new_instance.dot')

  end

  it "initial layout" do
    l = Layout.initial_layout(@facilities)
    expect(l.class).to eq(Layout)
    mhc = MaterialHandlingCosts.new(l)
    d = mhc.material_flow_distance
    p d
  end

end
