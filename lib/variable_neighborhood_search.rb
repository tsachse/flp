class VariableNeighborhoodSearch
  attr_reader :facilities
  attr_reader :initial_layout
  attr_reader :best_layout
  attr_reader :iter
  attr_reader :best_iter

  def initialize(facilities)
    @facilities = facilities
    @modifiable_params = Layout.modifiable_params
    @iter = 0
  end

  def local_search(best, max_no_improv, neighborhood)
    count = 0
    while count < max_no_improv
      candidate = Layout.another_modifed_layout(best)
      candidate.mhc = MaterialHandlingCosts.new(candidate)
      candidate.mhc.material_flow_distance
      if candidate.mhc.distance < best.mhc.distance
	best = candidate
	count = 0
      else
	count += 1
      end
    end
    best
  end

  def search(neighborhoods, max_no_improv, max_no_improv_ls)
    @initial_layout = Layout.initial_layout(@facilities)
    @initial_layout.mhc  = MaterialHandlingCosts.new(@initial_layout)
    @initial_layout.mhc.material_flow_distance
    @best_layout = @initial_layout
    @iter, count = 0, 0
    while count < max_no_improv 
      neighborhoods.each do |neigh|
	modify_params = { @modifiable_params[(iter % @modifiable_params.size)] => neigh }
	candidate = Layout.modifed_layout(@best_layout, modify_params)
	candidate.mhc = MaterialHandlingCosts.new(candidate) 
	candidate.mhc.material_flow_distance
	candidate = local_search(candidate, max_no_improv_ls, neigh) 
	if candidate.mhc.distance < @best_layout.mhc.distance
	  @best_layout = candidate
	  @best_iter = @iter
	  count = 0
	  # break # warum?
	else
	  count += 1
	end
	@iter += 1 
      end
    end 
    @best_layout
  end

end
