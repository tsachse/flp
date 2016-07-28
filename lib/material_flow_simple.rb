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

    calculate_costs

    @layout.material_flow = self

  end

  def calculate_costs
    @distance = 0
    @costs = 0
    @ordered_material_flow.each do |e|
      start, stop, items = e
      f1 = @facility_map[start]
      f2 = @facility_map[stop]
      dist = Facility.distance(f1.center,f2.center)
      # p "#{start}, #{stop}, #{dist.to_s}"
      # p dist
      @distance = @distance + dist
      @costs = @costs + (dist * items)
    end
    @costs
  end

end
