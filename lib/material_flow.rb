class MaterialFlow
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

    build_layout_graph

    @direct_mf_connections = []
    add_direct_connections
    @direct_mf_connections.each { |edge| @layout_edges << edge }

    layout_graph_instance

    find_feeding
    calculate_costs

    @layout.material_flow = self

  end

  def build_layout_graph
    @layout_edges = []
    af = @layout.arranged_facilities
    af.each_with_index do |f1,i|
      facility_edges(f1)
      if (i + 1 < af.size)
	f2 = af[i + 1] 
	connect_neigbours(f1, f2)
      end
    end
  end

  def layout_graph_instance
    @layout_graph = DijkstraGraph.new(@layout_edges.uniq)
  end

  def connect_neigbours(f_start, f_stop)
    p_start = [f_start.north, f_start.west, f_start.south, f_start.east]
    p_stop  = [f_stop.north,  f_stop.west,  f_stop.south,  f_stop.east]
    dir     = [:n, :w, :s, :e]
    p_start.each_with_index do |p1, i|
      x1,y1 = p1
      p_stop.each_with_index do |p2, j|
	x2,y2 = p2
	edge = nil
	@layout.arranged_facilities.each do |f|
	    if f.intersects_line?(x1, y1, x2, y2)
	      edge = nil
	      break
	    else
	      d = Facility.distance(p1,p2)
	      edge = ["#{f_start.id.to_s}_#{dir[i]}", "#{f_stop.id.to_s}_#{dir[j]}", d]
	    end
	end
	# p edge if edge != nil
	@layout_edges << edge if edge != nil
	end
      end
  end

  def add_direct_connections
    @direct_mf_connections = []
    @ordered_material_flow.each do |e|
      start, stop, items = e
      f_start = @facility_map[start]
      f_stop = @facility_map[stop]
      p_start = [f_start.north, f_start.west, f_start.south, f_start.east]
      p_stop  = [f_stop.north,  f_stop.west,  f_stop.south,  f_stop.east]
      dir     = [:n, :w, :s, :e]
      p_start.each_with_index do |p1, i|
	x1,y1 = p1
	p_stop.each_with_index do |p2, j|
	  x2,y2 = p2
	  edge = nil
	  @layout.arranged_facilities.each do |f|
	      if f.intersects_line?(x1, y1, x2, y2)
		edge = nil
		break
	      else
		d = Facility.distance(p1,p2)
		edge = ["#{f_start.id.to_s}_#{dir[i]}", "#{f_stop.id.to_s}_#{dir[j]}", d]
	      end
	  end
	  @direct_mf_connections << edge if edge != nil
	end
      end
    end
    @direct_mf_connections
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
	    v1 = "#{f_start.id.to_s}_#{p_start[i]}" 
	    v2 = "#{f_stop.id.to_s}_#{p_stop[j]}" 
	    # path, dist = @layout_graph.shortest_path(v1, v2)
	    dist = @layout_graph.shortest_distance(v1, v2)
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
  end

  def calculate_costs
    @distance = 0
    @costs = 0
    @ordered_material_flow.each do |e|
      start, stop, items = e
      f1 = @facility_map[start]
      f2 = @facility_map[stop]
      start = "#{f1.id.to_s}_#{f1.feeding.to_s}"
      stop  = "#{f2.id.to_s}_#{f2.feeding.to_s}"
      dist = @layout_graph.shortest_distance(start, stop)
      # p "#{start}, #{stop}, #{dist.to_s}"
      # p dist
      @distance = @distance + dist
      @costs = @costs + (dist * items)
    end
    @costs
  end

  def facility_edges(f)
    distance = f.width/2 + f.height/2
    @layout_edges << ["#{f.id.to_s}_n", "#{f.id.to_s}_e", distance]
    @layout_edges << ["#{f.id.to_s}_e", "#{f.id.to_s}_s", distance]
    @layout_edges << ["#{f.id.to_s}_s", "#{f.id.to_s}_w", distance]
    @layout_edges << ["#{f.id.to_s}_w", "#{f.id.to_s}_n", distance]
  end

  def neighbour_direction(f1, f2)
    n = false
    e = false
    w = false
    s = false
    n = true if f1.y1 > f2.y1
    w = true if f2.x1 < f1.x1
    e = true if f1.x1 < f2.x1
    s = true if f2.y1 > f1.y1
    if n
      if w
	return :nw
      end
      if e 
	return :ne
      end
      return :n
    end
    if s
      if w
	return :sw
      end
      if e 
	return :se
      end
      return :s
    end
    return :e if e
    return :w if w
    nil
  end

end
