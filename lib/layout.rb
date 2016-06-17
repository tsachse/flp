class Layout
  attr_reader :facilities
  attr_reader :silicing_order
  attr_reader :orientation
  attr_reader :facility_set

  def initialize(facilities, silicing_order, orientation)
    @facilities = facilities
    @silicing_order = silicing_order
    @orientation = orientation
    @facility_set = []
    @facility_set << FacilitySet.new(@facilities)

    ok = true
    while ok
      fs = []
      @facility_set.each do |f|
	if f.can_cut?(split_position)
	  s = f.cut_facilities(split_position)
	  fs << FacilitySet.new(s[0])
	  fs << FacilitySet.new(s[1])
	else
	  fs << f
	end 
      end
      @facility_set = fs
      ok = next_split_position != nil
      p @facility_set.size if ok
    end
  end

  def next_split_position

    sp = @silicing_order.shift
    return nil if sp == nil

    @facilities[sp]
    
  end

  def split_position

    sp = @silicing_order.first
    return nil if sp == nil

    @facilities[sp].id
    
  end


end


