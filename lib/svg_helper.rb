require 'rasem'
# require 'layout'

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

  def self.json_to_svg(json_facilities)
    colors = ['red','green','blue','yellow','brown','pink','cyan',
    'cornsilk', 'darkgreen', 'bisque', 'aqua', 'darkred', 'darkgoldenrod']
    i = 0
    feeding_size = 3
    facilities = JSON.parse(json_facilities)
    width = height = 0
    facilities.each do |f|
      if f['x2'] > width
	width = f['x2']
      end
      if f['y2'] > height
	height = f['y2']
      end
    end
    r = 480.0 / width 
    r = 640.0 / height if height > width
    feeding_size = width / 50.0 
    # p feeding_size
    facilities.each do |f|
      case f['feeding']
      when 'n'
	f['xf'] = (f['x1'] + (f['width']/2))
	f['yf'] = f['y1'] 
      when 'w'
	f['xf'] = f['x1']
	f['yf'] = (f['y1'] + (f['height']/2)) 
      when 's'
	f['xf'] = (f['x1'] + (f['width']/2))
	f['yf'] = f['y2'] - feeding_size
      when 'e'
	f['xf'] = f['x2'] - feeding_size
	f['yf'] = (f['y1'] + (f['height']/2)) 
      end 
      # p "#{f['id']} #{f['feeding']} #{f['xf']} #{f['yf']}"
    end
    img = Rasem::SVGImage.new(width * r ,height * r) do 
      group :stroke=>"black" do
	facilities.each do |f|
	  rectangle f['x1'] * r, 
	    f['y1'] * r, 
	    f['width'] * r, 
	    f['height'] * r, 
	    :stroke_width=>1, :fill=>colors[i%colors.size]
	  rectangle f['xf'] * r, 
	    f['yf'] * r, 
	    feeding_size * r, 
	    feeding_size * r, 
	    :stroke_width=>1, :fill=>"gray"
	  tx = f['x1'] * r + f['width'] / 2 * r
	  ty = f['y1'] * r + f['height'] / 2 * r
	  text tx, ty, f['id'], {"font-size" => 12}
	  i = i + 1
	end
      end
    end
    img
  end

  def self.json_to_svg_file(facilities, filename)
    img = json_to_svg(facilities)
    File.open(filename, "w") do |f|
      f << img.output
    end
  end
end
