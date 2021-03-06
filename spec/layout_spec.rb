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
    @output_path_pattern = File.dirname(__FILE__) + '/output/layout_'
  end

  it "new instance" do
    silicing_order = [4,3,2,1,0,5]
    orientation =    [0,0,1,1,1,0]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    expect(l.facility_set_ids).to eq([[:f2], [:f6], [:f3], [:f4], [:f5], [:f0], [:f1]])
    expect(l.arranged_facilities[0].id).to eq(:f2)
    expect(l.arranged_facilities[1].id).to eq(:f6)
    expect(l.arranged_facilities[2].id).to eq(:f3)
    expect(l.arranged_facilities[3].id).to eq(:f4)
    expect(l.arranged_facilities[4].id).to eq(:f5)
    expect(l.arranged_facilities[5].id).to eq(:f0)
    expect(l.arranged_facilities[6].id).to eq(:f1)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'new_instance.svg')
  end

  it "a horizontal cut" do
    silicing_order = [4]
    orientation = [0]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    expect(l.facility_set_ids).to eq([[:f2, :f6, :f3, :f4, :f5], [:f0, :f1]])
    fs1 = l.facility_set[0]
    expect(fs1.width).to eq(1300)
    expect(fs1.height).to eq(1300)
    expect(fs1.x1).to eq(0)
    expect(fs1.y1).to eq(400)
    expect(fs1.x2).to eq(1300)
    expect(fs1.y2).to eq(1700)
    fs2 = l.facility_set[1]
    expect(fs2.width).to eq(200)
    expect(fs2.height).to eq(400)
    expect(fs2.x1).to eq(0)
    expect(fs2.y1).to eq(0)
    expect(fs2.x2).to eq(200)
    expect(fs2.y2).to eq(400)
    expect(l.arranged_facilities).to eq([])
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'horizontal_cut.svg')
  end

  it "a vertical cut" do
    silicing_order = [4]
    orientation = [1]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    expect(l.facility_set_ids).to eq([[:f2, :f6, :f3, :f4, :f5], [:f0, :f1]])
    fs1 = l.facility_set[0]
    expect(fs1.width).to eq(1300)
    expect(fs1.height).to eq(1300)
    expect(fs1.x1).to eq(0)
    expect(fs1.y1).to eq(0)
    expect(fs1.x2).to eq(1300)
    expect(fs1.y2).to eq(1300)
    fs2 = l.facility_set[1]
    expect(fs2.width).to eq(200)
    expect(fs2.height).to eq(400)
    expect(fs2.x1).to eq(1300)
    expect(fs2.y1).to eq(0)
    expect(fs2.x2).to eq(1500)
    expect(fs2.y2).to eq(400)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'vertical_cut.svg')
  end

  it "two cuts" do
    silicing_order = [4,3]
    orientation    = [0,0,1,1,1,0]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'two_cuts.svg')
  end

  it "three cuts" do
    silicing_order = [4,3,2]
    orientation    = [0,0,1,1,1,0]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'three_cuts.svg')
  end

  it "four cuts" do
    silicing_order = [4,3,2,1]
    orientation    = [0,0,1,1,1,0]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'four_cuts.svg')
  end

  it "five cuts" do
    silicing_order = [4,3,2,1,0]
    orientation    = [0,0,1,1,1,0]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'five_cuts.svg')
  end

  it "five cuts 2" do
    silicing_order = [4,3,2,1,0]
    orientation    = [0,0,1,1,0,0]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'five_cuts2.svg')
  end

  it "gap" do
    silicing_order = [4,3,2,1,0,5]
    orientation    = [0,0,1,1,0,0]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'gap.svg')
  end

  it "initial layout" do
    l = Layout.initial_layout(@facilities)
    expect(l.class).to eq(Layout)
    expect(l.silicing_order.size + 1).to eq(@facilities.size)
    expect(l.orientation.size + 1).to eq(@facilities.size)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'initial_layout.svg')
  end

  it "stochastic swap" do
    v1 = [1,2,3,4,5]
    v2 = Layout.stochastic_swap(v1)
    expect(v1.size).to eq(v2.size)
    expect(v1).not_to contain_exactly(v2)
  end

  it "stochastic orientaion swap" do
    v1 = [1,1,1,1,1]
    v2 = Layout.stochastic_orientation_swap(v1)
    expect(v1.size).to eq(v2.size)
    expect(v2).not_to contain_exactly(v1)
    expect(v2).to  include(0)
    v1 = [0,0,0,0,0]
    v2 = Layout.stochastic_orientation_swap(v1)
    expect(v1.size).to eq(v2.size)
    expect(v2).not_to contain_exactly(v1)
    expect(v2).to  include(1)
  end

  it "modifiable params" do
    v = Layout.modifiable_params
    expect(v).to match_array([:facilitiy_order, :silicing_order, :orientation])
    p = Layout.random_modifiable_param
    expect(v).to include(p)
  end

  it "modified layout" do
    silicing_order = [0,1,2,3,4,5]
    orientation    = [0,0,0,0,0,0]
    l1 = Layout.new(@facilities,silicing_order,orientation)
    l2 = Layout.modifed_layout(l1, {:facilitiy_order => 1,:silicing_order => 1, :orientation => 1 })
    expect(l2.class).to eq(Layout)
    facilities2     = l2.facilities
    silicing_order2 = l2.silicing_order
    orientation2    = l2.orientation
    expect(facilities2).not_to contain_exactly(@facilities)
    expect(facilities2.size).to eq(@facilities.size)
    expect(silicing_order2).not_to contain_exactly(silicing_order)
    expect(silicing_order2.size).to eq(silicing_order.size)
    expect(orientation2).to include(1)
    expect(orientation2.size).to eq(orientation.size)
    SVGHelper.layout_to_svg_file(l1,@output_path_pattern + 'modfied_layout_l1.svg')
    SVGHelper.layout_to_svg_file(l2,@output_path_pattern + 'modfied_layout_l2.svg')
  end

  it "another modified layout" do
    silicing_order = [0,1,2,3,4,5]
    orientation    = [0,0,0,0,0,0]
    l1 = Layout.new(@facilities,silicing_order,orientation)
    l2 = Layout.modifed_layout(l1, {:facilitiy_order => 1,:silicing_order => 1, :orientation => 1 })
    l3 = Layout.another_modifed_layout(l2)
    expect(l3.class).to eq(Layout)
    expect(l3).not_to eq(l2)
    facilities3     = l3.facilities
    silicing_order3 = l3.silicing_order
    orientation3    = l3.orientation
    expect(facilities3).not_to contain_exactly(@facilities)
    expect(facilities3.size).to eq(@facilities.size)
    expect(silicing_order3).not_to contain_exactly(silicing_order)
    expect(silicing_order3.size).to eq(silicing_order.size)
    expect(orientation3.size).to eq(orientation.size)
    SVGHelper.layout_to_svg_file(l1,@output_path_pattern + 'another_modfied_layout_l1.svg')
    SVGHelper.layout_to_svg_file(l2,@output_path_pattern + 'another_modfied_layout_l2.svg')
    SVGHelper.layout_to_svg_file(l3,@output_path_pattern + 'another_modfied_layout_l3.svg')
  end
end
