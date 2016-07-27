class MaterialFlowFloyd < MaterialFlow

  def layout_graph_instance
    @layout_graph = FloydWarshall.new(@layout_edges.uniq, true)
  end

end
