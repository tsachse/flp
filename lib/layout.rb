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

  def arranged_facilities
    af = []
    @facility_set.each do |fs|
      if fs.facilities.size == 1
	f = fs.facilities.first.clone
	f.x1 = fs.x1
	f.x2 = fs.x2
	f.y1 = fs.y1
	f.y2 = fs.y2
	af << f
      end
    end
    af
  end

  def stochastic_swap(vector)
    v = vector.clone
    return v if v.size < 2
    i = rand(v.size)
    c1 = v[i]
    v.delete_at(i)
    i = rand(v.size)
    c2 = v[i]
    v.delete_at(i)
    i = rand(v.size) 
    v.insert(i, c1)
    i = rand(v.size)
    v.insert(i, c2)
  end

  def stochastic_orientation_swap(vector)
    v = vector.clone
    i = rand(v.size)
    if v[i] == 0
      v[i] = 1
    elsif v[i] == 1
      v[i] = 0
    end
    v
  end

  def self.initial_layout(facilties)
    silicing_order = (0..(facilties.size-1)).to_a.shuffle
    orientation = silicing_order.map { |v| v % 2 }
    Layout.new(facilties, silicing_order, orientation)
  end

  # TODO zu Ende impl && Test
  def self.modifed_layout(layout, which_params)
    facilities = layout.facilities
    silicing_order = layout.silicing_order
    orientation = layout.orientation
    which_params.keys.each do |k|
      case k
      when :facilitiy_order
	facilities = stochastic_swap(layout.facilities)
      when :silicing_order
	silicing_order = stochastic_swap(layout.silicing_order)
      when :orientation
	orientation = stochastic_orientaion_swap(layout.oriantion_order) 
      end
    end
  end

end


