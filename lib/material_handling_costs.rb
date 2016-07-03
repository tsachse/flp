class MaterialHandlingCosts
  attr_reader :layout
  attr_reader :material_flow_graph

  def initialize(layout)
    @layout = layout
    build_material_flow_graph
  end

  def build_material_flow_graph
    @material_flow_graph = []
    af = @layout.arranged_facilities
    af.each_with_index do |f1,i|
      facility_edges(f1)
      if (i + 1 < af.size)
	f2 = af[i + 1] 
	# p '---'
	direction = neighbour_direction(f1, f2)
	# p f1,f2,direction
	@material_flow_graph << connect_neigbours(f1, f2, direction)
      end
    end
  end

  def facility_edges(f)
    distance = f.width/2 + f.height/2
    @material_flow_graph << ["#{f.id.to_s}_n", "#{f.id.to_s}_e", distance]
    @material_flow_graph << ["#{f.id.to_s}_e", "#{f.id.to_s}_s", distance]
    @material_flow_graph << ["#{f.id.to_s}_s", "#{f.id.to_s}_w", distance]
    @material_flow_graph << ["#{f.id.to_s}_w", "#{f.id.to_s}_n", distance]
    #
    @material_flow_graph << ["#{f.id.to_s}_n", "#{f.id.to_s}_w", distance]
    @material_flow_graph << ["#{f.id.to_s}_w", "#{f.id.to_s}_s", distance]
    @material_flow_graph << ["#{f.id.to_s}_s", "#{f.id.to_s}_e", distance]
    @material_flow_graph << ["#{f.id.to_s}_e", "#{f.id.to_s}_n", distance]
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
