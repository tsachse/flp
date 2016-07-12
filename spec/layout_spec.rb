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
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'initial_layout.svg')
  end
end
