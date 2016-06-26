require 'spec_helper'

describe Layout do
  before(:each) do
    f0 = Facility.new(:f0, 10, 20)
    f1 = Facility.new(:f1, 10, 20)
    f2 = Facility.new(:f2, 30, 20)
    f3 = Facility.new(:f3, 30, 20)
    f4 = Facility.new(:f4, 30, 30)
    f5 = Facility.new(:f5, 10, 50)
    f6 = Facility.new(:f6, 30, 10)
    @facilities = [f2,f6,f3,f4,f5,f0,f1]
    @output_path_pattern = File.dirname(__FILE__) + '/output/layout_'
  end

  it "new instance" do
    silicing_order = [4,3,2,1,0,5]
    orientation = [0,0,1,1,0]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    expect(l.facility_set_ids).to eq([[:f2], [:f6], [:f3], [:f4], [:f5], [:f0], [:f1]])
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'new_instance.svg')
  end

  it "a horizontal cut" do
    silicing_order = [4]
    orientation = [0]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    expect(l.facility_set_ids).to eq([[:f2, :f6, :f3, :f4, :f5], [:f0, :f1]])
    fs1 = l.facility_set[0]
    expect(fs1.width).to eq(130)
    expect(fs1.height).to eq(130)
    expect(fs1.x1).to eq(0)
    expect(fs1.y1).to eq(40)
    expect(fs1.x2).to eq(130)
    expect(fs1.y2).to eq(170)
    fs2 = l.facility_set[1]
    expect(fs2.width).to eq(20)
    expect(fs2.height).to eq(40)
    expect(fs2.x1).to eq(0)
    expect(fs2.y1).to eq(0)
    expect(fs2.x2).to eq(20)
    expect(fs2.y2).to eq(40)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'horizontal_cut.svg')
  end

  it "a vertical cut" do
    silicing_order = [4]
    orientation = [1]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    expect(l.facility_set_ids).to eq([[:f2, :f6, :f3, :f4, :f5], [:f0, :f1]])
    fs1 = l.facility_set[0]
    expect(fs1.width).to eq(130)
    expect(fs1.height).to eq(130)
    expect(fs1.x1).to eq(0)
    expect(fs1.y1).to eq(0)
    expect(fs1.x2).to eq(130)
    expect(fs1.y2).to eq(130)
    fs2 = l.facility_set[1]
    expect(fs2.width).to eq(20)
    expect(fs2.height).to eq(40)
    expect(fs2.x1).to eq(130)
    expect(fs2.y1).to eq(0)
    expect(fs2.x2).to eq(150)
    expect(fs2.y2).to eq(40)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'vertical_cut.svg')
  end

  it "two cuts" do
    silicing_order = [4,3]
    orientation = [0,0,1,1,0]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'two_cuts.svg')
  end

  it "three cuts" do
    silicing_order = [4,3,2]
    orientation = [0,0,1,1,0]
    l = Layout.new(@facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + 'three_cuts.svg')
  end

end
