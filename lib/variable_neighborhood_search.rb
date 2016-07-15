class VariableNeighborhoodSearch
  attr_reader :facilities
  attr_reader :initial_layout
  attr_reader :best_layout

  def initialize(facilities)
    @facilities = facilities
  end

  def local_search(best, max_no_improv, neighborhood)
    count = 0
    while count < max_no_improv
      candidate = Layout.anoter_modifed_layout(best)
      candidate.mh_distance = MaterialHandlingCosts.new(candiate)
      if candiate.mh_distance < best.mh_distance
	best = candiate
	count = 0
      else
	count += 1
      end
    end
    best
  end

  def search(modify_params, neighborhoods, max_no_improv, max_no_improv_ls)
    @initial_layout = Layout.initial_layout(@facilties)
    @initial_layout.modify_params = modify_params
    @initial_layout.mh_distance  = MaterialHandlingCosts.new(@initial_layout)
    best = @initial_layout
    iter, count = 0, 0
    while count < max_no_improv 
      neighborhoods.each do |neigh|
	candidate = Layout.modifed_layout(best, modify_params)
	candidate.mh_distance = MaterialHandlingCosts.new(candiate) 
	candidate = local_search(candidate, max_no_improv_ls, neigh) 
	iter += 1 
	if candiate.mh_distance < best.mh_distance
	  best = candiate
	  count = 0
	  break # warum?
	else
	  count += 1
	end
      end
    end 
    @best_layout = best
  end

end
