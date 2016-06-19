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
    fs = FacilitySet.new(@facilities)
    @facility_set << fs

    ok = true
    while ok
      fs = []
      @facility_set.each do |f|
	if f.can_cut?(slice_position)
	  s = f.cut_facilities(slice_position)
	  fs1 = FacilitySet.new(s[0], f.x1, f.y1)
	  fs2 = FacilitySet.new(s[1], f.x1, f.y1)
	  if slice_orientation == 0
	    # Set 2
	    fs2.y2 = fs2.y1 + fs2.height
	    fs2.x2 = fs2.x1 + fs2.width
	    # Set 1 
	    fs1.y1 = fs1.y1 + fs2.height
	    fs1.y2 = fs1.y1 + fs1.height
	    fs1.x2 = fs1.x1 + fs1.width
	  else
	    # Set 1
	    fs1.y2 = fs1.y1 + fs1.height
	    fs1.x2 = fs1.x1 + fs1.width
	    # Set 2
	    fs2.x1 = fs2.x1 + fs1.width
	    fs2.y2 = fs2.y1 + fs2.height
	    fs2.x2 = fs2.x1 + fs2.width
	  end
	  fs << fs1
	  fs << fs2
	else
	  fs << f
	end 
      end
      @facility_set = fs
      ok = next_slice_position != nil
      # p @facility_set.size if ok
    end
  end

  def next_slice_position
    sp = @silicing_order.shift
    return nil if sp == nil
    @orientation.shift
    @facilities[sp]
  end

  def slice_position
    sp = @silicing_order.first
    return nil if sp == nil
    @facilities[sp].id
  end

  def slice_orientation
    @orientation.first
  end

  def facility_set_ids
    @facility_set.map { |f| f.facility_ids }
  end


end


