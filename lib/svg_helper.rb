require 'rasem'
require 'layout'

class SVGHelper
  def self.layout_to_svg(layout)
    colors = ['red','green','blue','yellow','brown','pink','cyan','gray']
    i = 0
    tmp = FacilitySet.new(layout.facilities) 
    r = 800.0 / tmp.width 
    img = Rasem::SVGImage.new(tmp.width * r ,tmp.height * r) do
      group :stroke=>"black" do
	layout.facility_set.each do |fs|
	  rectangle fs.x1 * r, 
	    fs.y1 * r, 
	    fs.width * r, 
	    fs.height * r, 
	    :stroke_width=>1, :fill=>colors[i%colors.size]
	  tx = fs.x1 * r + fs.width / 2 * r
	  ty = fs.y1 * r + fs.height / 2 * r
	  text tx, ty, fs.label, {"font-size" => 12}
	  i = i + 1
	end
      end
    end
    img
  end

  def self.layout_to_svg_file(layout, filename)
    img = layout_to_svg(layout)
    File.open(filename, "w") do |f|
      f << img.output
    end
  end
end
