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
    @facility_set << @facilities

    ok = true
    while ok
      fs = []
      @facility_set.each do |f|
	if can_split?(f)
	  s = split_facility_set(f)
	  fs << s[0]
	  fs << s[1]
	else
	  fs << f
	end 
      end
      @facility_set = fs
      ok = next_split_position != nil
      # p @facility_set if ok
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

    @facilities[sp]
    
  end

  def can_split?(facility_set)
    return false if facility_set.size < 2
    return (facility_set.grep(split_position)) != []
  end

  def split_facility_set(facility_set)
    first_set = true
    two_sets = facility_set.partition do |f|
      s = first_set
      first_set = false if f == split_position
      s
    end
  end

end


