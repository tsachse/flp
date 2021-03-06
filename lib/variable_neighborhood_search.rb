class VariableNeighborhoodSearch
  attr_reader :facilities
  attr_reader :material_flow
  attr_reader :initial_layout
  attr_reader :best_layout
  attr_reader :iter
  attr_reader :best_iter
  attr_accessor :mf_klass

  def initialize(facilities, material_flow)
    @mf_klass = MaterialFlow
    @facilities = facilities
    @material_flow = material_flow
    @modifiable_params = Layout.modifiable_params
    @iter = 0
    @best_iter = 0
  end

  def local_search(best, max_no_improv, neighborhood)
    count = 0
    while count < max_no_improv
      candidate = Layout.another_modifed_layout(best)
      candidate.material_flow = @mf_klass.new(candidate,@material_flow)
      if candidate.material_flow.costs < best.material_flow.costs
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
    @initial_layout.material_flow  = @mf_klass.new(@initial_layout, @material_flow)
    @best_layout = @initial_layout
    @iter, count = 0, 0
    while count < max_no_improv 
      # param = @modifiable_params[(iter % @modifiable_params.size)]
      neighborhoods.each do |neigh|
	@iter += 1 
	param = @modifiable_params[(iter % @modifiable_params.size)]
	modify_params = { param => neigh }
	candidate = Layout.modifed_layout(@best_layout, modify_params)
	candidate.material_flow = @mf_klass.new(candidate,@material_flow) 
	candidate = local_search(candidate, max_no_improv_ls, neigh) 
	if candidate.material_flow.costs < @best_layout.material_flow.costs
	  @best_layout = candidate
	  @best_iter = @iter
	  count = 0
	  break # restart search
	else
	  count += 1
	end
      end
    end 
    @best_layout
  end

end
