require File.dirname(__FILE__) + '/../spec/spec_helper'

describe Layout do
  before(:each) do
    @f0 = Facility.new(:f0, 30, 40)
    @f1 = Facility.new(:f1, 20, 40)
    @f2 = Facility.new(:f2, 80, 50)
    @f3 = Facility.new(:f3, 40, 20)
    @f4 = Facility.new(:f4, 40, 80)
    @output_path_pattern = File.dirname(__FILE__) + '/output/simple_05_layout_'
  end

  it "Simple 05 Variante 1" do
    facilities = [@f0,@f1,@f2,@f3,@f4]
    silicing_order = [2,1,0,3]
    orientation =    [0,0,1,1]
    l = Layout.new(facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + '1.svg')
  end

  it "Simple 05 Variante 2" do
    facilities = [@f2,@f0,@f1,@f4,@f3]
    silicing_order = [2,0,1,3]
    orientation =    [0,0,1,1]
    l = Layout.new(facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + '2.svg')
  end

  it "Simple 05 Variante 2 - 1 " do
    facilities = [@f2,@f0,@f1,@f4,@f3]
    silicing_order = [2]
    orientation =    [0,0,1,1]
    l = Layout.new(facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + '2_1.svg')
  end

  it "Simple 05 Variante 2 - 2" do
    facilities = [@f2,@f0,@f1,@f4,@f3]
    silicing_order = [2,0]
    orientation =    [0,0,1,1]
    l = Layout.new(facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + '2_2.svg')
  end

  it "Simple 05 Variante 2 - 3" do
    facilities = [@f2,@f0,@f1,@f4,@f3]
    silicing_order = [2,0,1]
    orientation =    [0,0,1,1]
    l = Layout.new(facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
    img = SVGHelper.layout_to_svg_file(l,@output_path_pattern + '2_3.svg')
  end

end
