require 'rasem'
require 'layout'

class SVGHelper
  def self.layout_to_svg(layout)
    tmp = FacilitySet.new(layout.facilities) 
    img = Rasem::SVGImage.new(tmp.width,tmp.height) do
      group :stroke=>"black" do
	layout.facility_set.each do |fs|
	  rectangle fs.x1, fs.y1, fs.x2 - fs.x1, fs.y2 - fs.y1, :stroke_width=>2, :fill=>"white"
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
