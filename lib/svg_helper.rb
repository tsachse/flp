require 'rasem'
require 'layout'

class SVGHelper
  def self.layout_to_svg(layout)
    colors = ['red','green','blue','yellow','brown','pink','cyan','gray']
    i = 0
    tmp = FacilitySet.new(layout.facilities) 
    img = Rasem::SVGImage.new(tmp.width,tmp.height) do
      group :stroke=>"black" do
	layout.facility_set.each do |fs|
	  rectangle fs.x1, 
	    fs.y1, 
	    fs.width, 
	    fs.height, 
	    :stroke_width=>1, :fill=>colors[i%colors.size]
	  tx = fs.x1 + fs.width / 2
	  ty = fs.y1 + fs.height / 2
	  text tx, ty, fs.label
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
