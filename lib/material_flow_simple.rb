class MaterialFlowSimple
  attr_reader :layout
  attr_reader :material_flow
  attr_reader :ordered_material_flow
  attr_reader :layout_edges
  attr_reader :direct_mf_connections
  attr_reader :layout_graph
  # attr_reader :layout_path
  attr_reader :facility_map
  attr_reader :distance
  attr_reader :costs

  def initialize(layout, material_flow)
    @layout = layout
    @material_flow = material_flow
    @ordered_material_flow = @material_flow.sort do |a,b|
      a_start, a_stop, a_items = a
      b_start, b_stop, b_items = b
      b_items <=> a_items
    end
    @facility_map = {}
    @layout.arranged_facilities.each do |f|
      @facility_map[f.id] = f
      f.feeding = nil # Aufgabepunkte sollen neu berechnet werden
    end

    @feeding_map = {
      :n => :north,
      :w => :west,
      :s => :south,
      :e => :east,
    }

    find_feeding 
    calculate_costs

    @layout.material_flow = self

  end

  def find_feeding
    @ordered_material_flow.each do |e|
      start, stop, items = e
      f_start = @facility_map[start]
      f_stop = @facility_map[stop]
      p_start = p_stop = [:n, :w, :s, :e]
      p_start = [f_start.feeding] if f_start.feeding != nil
      p_stop  = [f_stop.feeding]  if f_stop.feeding != nil
      if p_start.size > 1 || p_stop.size > 1
	min = Float::INFINITY
	p_start.each_with_index do |p1, i|
	  p_stop.each_with_index do |p2, j| 
	    v1 = f_start.send @feeding_map[p_start[i]]
	    v2 = f_stop.send @feeding_map[p_stop[j]]
	    dist = Facility.distance(v1,v2) 
	    if dist < min
	      min = dist
	      f_start.feeding = p_start[i] if p_start.size > 1
	      f_stop.feeding = p_stop[j] if p_stop.size > 1
	      # p "#{f_start.id} #{f_start.feeding}, #{f_stop.id} #{f_stop.feeding}, #{dist.to_s}" 
	    end
	  end
	 end
	end
     end
     @facility_map.values.each do |f| 
       f.feeding = :e if f.feeding == nil
     end
  end

  def calculate_costs
    @distance = 0
    @costs = 0
    @ordered_material_flow.each do |e|
      start, stop, items = e
      f1 = @facility_map[start]
      f2 = @facility_map[stop]
      v1 = f1.send @feeding_map[f1.feeding]
      v2 = f2.send @feeding_map[f2.feeding]
      dist = Facility.distance(v1,v2)
      # p "#{start}, #{stop}, #{dist.to_s}"
      # p dist
      @distance = @distance + dist
      @costs = @costs + (dist * items)
    end
    @costs
  end

end
