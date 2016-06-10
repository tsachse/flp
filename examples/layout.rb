facilities = [2,6,3,4,5,0,1]
silicing_order = [4,3,2,1,0,5]
orientation = [0,0,1,1,0]

def next_split_position(facilities,silicing_order)

  sp = silicing_order.shift
  return nil if sp == nil

  facilities[sp]
  
end

def split_position(facilities,silicing_order)

  sp = silicing_order.first
  return nil if sp == nil

  facilities[sp]
  
end

def can_split?(facility_set,facilities,silicing_order)
  return false if facility_set.size < 2
  return (facility_set.grep(split_position(facilities,silicing_order))) != []
end

def split_facility_set(facility_set,facilities,silicing_order)
  first_set = true
  two_sets = facility_set.partition do |f|
    s = first_set
    first_set = false if f == split_position(facilities,silicing_order)
    s
  end

end


facility_set = []
facility_set << facilities
ok = true
while ok
  fs = []
  facility_set.each do |f|
    if can_split?(f,facilities,silicing_order)
      s = split_facility_set(f,facilities,silicing_order)
      fs << s[0]
      fs << s[1]
    else
      fs << f
    end 
  end
  facility_set = fs
  ok = next_split_position(facilities,silicing_order) != nil
  p facility_set if ok
end

