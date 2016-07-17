class MaterialFlow
  attr_reader :layout
  attr_reader :material_flow
  attr_reader :layout_edges
  attr_reader :layout_graph
  attr_reader :layout_path
  attr_reader :facility_map
  attr_reader :distance

  def initialize(layout, material_flow)
    @layout = layout
    @material_flow = material_flow
    @facility_map = {}
    @layout.arranged_facilities.each do |f|
      @facility_map[f.id] = f
      f.feeding = nil # Aufgabepunkte sollen neu berechnet werden
    end
    build_layout_graph
    # @layout_graph = DijkstraGraph.new(@layout_edges)
  end

  def build_layout_graph
    @layout_edges = []
    af = @layout.arranged_facilities
    af.each_with_index do |f1,i|
      facility_edges(f1)
      if (i + 1 < af.size)
	f2 = af[i + 1] 
	direction = neighbour_direction(f1, f2)
	@layout_edges << connect_neigbours(f1, f2, direction)
	direction = neighbour_direction(f2, f1)
	@layout_edges << connect_neigbours(f2, f1, direction) 
      end
    end
    @layout_graph = DijkstraGraph.new(@layout_edges)
  end

  def add_direct_connections
    mf = @material_flow.sort do |a,b|
      a_start, a_stop, a_items = a
      b_start, b_stop, b_items = b
      b_items <=> a_items
    end
    mf.each do |i|
      start, stop, items = i
      f_start = @facility_map[start]
      f_stop = @facility_map[stop]
      direction = neighbour_direction(f_start, f_stop)
      p direction
      edge = connect_neigbours(f_start, f_stop, direction)
      p edge
    end
  end

  def layout_distance
    @layout_path = []
    @distance = 0
    af = @layout.arranged_facilities
    af.each_with_index do |f1,i|
      if (i + 1 < af.size)
	f2 = af[i + 1] 
	start = "#{f1.id.to_s}_#{f1.feeding.to_s}"
	stop  = "#{f2.id.to_s}_#{f2.feeding.to_s}"
	path, dist = @layout_graph.shortest_path(start, stop)
	@distance = @distance + dist
	@layout_path << path

	# p '---'
	p start, stop, dist, path
	# @layout_edges << connect_neigbours(f1, f2, direction)
      end
    end
    @layout_path = @layout_path
    @distance
  end

  def facility_edges(f)
    distance = f.width/2 + f.height/2
    @layout_edges << ["#{f.id.to_s}_n", "#{f.id.to_s}_e", distance]
    @layout_edges << ["#{f.id.to_s}_e", "#{f.id.to_s}_s", distance]
    @layout_edges << ["#{f.id.to_s}_s", "#{f.id.to_s}_w", distance]
    @layout_edges << ["#{f.id.to_s}_w", "#{f.id.to_s}_n", distance]
    #
    @layout_edges << ["#{f.id.to_s}_n", "#{f.id.to_s}_w", distance]
    @layout_edges << ["#{f.id.to_s}_w", "#{f.id.to_s}_s", distance]
    @layout_edges << ["#{f.id.to_s}_s", "#{f.id.to_s}_e", distance]
    @layout_edges << ["#{f.id.to_s}_e", "#{f.id.to_s}_n", distance]
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

  def connect_neigbours(f1,f2,direction)
    edge = []
    case direction
    when :n
      edge << "#{f1.id.to_s}_n"
      edge << "#{f2.id.to_s}_s"
      edge << Facility.distance(f1.north,f2.south)
    when :nw
      edge << "#{f1.id.to_s}_n"
      edge << "#{f2.id.to_s}_e"
      edge << Facility.distance(f1.north,f2.east)
    when :ne
      edge << "#{f1.id.to_s}_n"
      edge << "#{f2.id.to_s}_w"
      edge << Facility.distance(f1.north,f2.west)
    when :e
      edge << "#{f1.id.to_s}_e"
      edge << "#{f2.id.to_s}_w"
      edge << Facility.distance(f1.east,f2.west)
    when :w
      edge << "#{f1.id.to_s}_w"
      edge << "#{f2.id.to_s}_e"
      edge << Facility.distance(f1.west,f2.east)
    when :s
      edge << "#{f1.id.to_s}_s"
      edge << "#{f2.id.to_s}_n"
      edge << Facility.distance(f1.south,f2.north)
    when :sw
      edge << "#{f1.id.to_s}_s"
      edge << "#{f2.id.to_s}_e"
      edge << Facility.distance(f1.south,f2.east)
    when :se
      edge << "#{f1.id.to_s}_s"
      edge << "#{f2.id.to_s}_w"
      edge << Facility.distance(f1.south,f2.west)
    end
  end

end
