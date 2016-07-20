require File.dirname(__FILE__) + '/../lib/layout.rb'
require File.dirname(__FILE__) + '/../lib/facility.rb'
require File.dirname(__FILE__) + '/../lib/facility_set.rb'
require File.dirname(__FILE__) + '/../lib/svg_helper.rb'
require File.dirname(__FILE__) + '/../lib/dot_helper.rb'
require File.dirname(__FILE__) + '/../lib/dijkstra_graph.rb'
require File.dirname(__FILE__) + '/../lib/variable_neighborhood_search.rb'
require File.dirname(__FILE__) + '/../lib/material_flow.rb'

require 'logger'

class DatasetHelper 
  def self.run(dataset_name, facilities, material_flow, neighbours, max_no_improv, max_no_improv_ls)
    fn_logfile = File.dirname(__FILE__) + '/output/dataset.log'
    output_path_pattern = File.dirname(__FILE__) + '/output/' + dataset_name + '_'

    logger = Logger.new(fn_logfile)
    logger.info("Start " +  dataset_name + " ****************************")
    logger.info('facilities: ' + facilities.inspect.to_s)
    logger.info('material_flow: ' + material_flow.inspect.to_s)
    logger.info('neighbours: ' + neighbours.inspect.to_s)
    logger.info('max_no_improv: ' + max_no_improv.inspect.to_s)
    logger.info('max_no_improv_ls: ' + max_no_improv_ls.inspect.to_s)

    vns = VariableNeighborhoodSearch.new(facilities, material_flow)
    best = vns.search(neighbours,max_no_improv, max_no_improv_ls)
    initial = vns.initial_layout

    logger.info('vns.iter: ' + vns.iter.inspect.to_s)
    logger.info('vns.best_iter: ' + vns.best_iter.inspect.to_s)
    logger.info('initial.material_flow.costs: ' + initial.material_flow.costs.inspect.to_s)
    logger.info('initial.material_flow.costs: ' + initial.material_flow.costs.inspect.to_s)
    logger.info('initial.material_flow.distance: ' + initial.material_flow.distance.inspect.to_s)
    logger.info('initial.material_flow.facility_map: ' + initial.material_flow.facility_map.inspect.to_s)
    logger.info('best.material_flow.costs: ' + best.material_flow.costs.inspect.to_s)
    logger.info('best.material_flow.distance: ' + best.material_flow.distance.inspect.to_s)
    logger.info('best.material_flow.facility_map: ' + best.material_flow.facility_map.inspect.to_s)
    logger.info("Stop  " +  dataset_name + " ****************************")
    logger.close

    SVGHelper.layout_to_svg_file(initial,output_path_pattern + 'initial_layout.svg')
    SVGHelper.layout_to_svg_file(best,output_path_pattern + 'best_layout.svg')

    vns
  end

end

