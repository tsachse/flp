class TimedVariableNeighborhoodSearch
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

  def local_search(best, max_duration, neighborhood)
    start = Time.now.to_f
    while (Time.now.to_f - start) <= max_duration
      candidate = Layout.another_modifed_layout(best)
      candidate.material_flow = @mf_klass.new(candidate,@material_flow)
      if candidate.material_flow.costs < best.material_flow.costs
	best = candidate
      end
    end
    best
  end

  def search(neighborhoods, max_duration, max_duration_ls)
    @initial_layout = Layout.initial_layout(@facilities)
    @initial_layout.material_flow  = @mf_klass.new(@initial_layout, @material_flow)
    @best_layout = @initial_layout
    @iter = 0
    start = Time.now.to_f
    while (Time.now.to_f - start) <= max_duration 
      # param = @modifiable_params[(iter % @modifiable_params.size)]
      neighborhoods.each do |neigh|
	break if (Time.now.to_i - start) >= max_duration 
	@iter += 1 
	param = @modifiable_params[(iter % @modifiable_params.size)]
	modify_params = { param => neigh }
	candidate = Layout.modifed_layout(@best_layout, modify_params)
	candidate.material_flow = @mf_klass.new(candidate,@material_flow) 
	candidate = local_search(candidate, max_duration_ls, neigh) 
	if candidate.material_flow.costs < @best_layout.material_flow.costs
	  @best_layout = candidate
	  @best_iter = @iter
	  break # restart search
	end
      end
    end 
    @best_layout
  end

end
