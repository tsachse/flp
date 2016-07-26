require File.dirname(__FILE__) + '/../lib/layout.rb'
require File.dirname(__FILE__) + '/../lib/facility.rb'
require File.dirname(__FILE__) + '/../lib/facility_set.rb'
require File.dirname(__FILE__) + '/../lib/svg_helper.rb'
require File.dirname(__FILE__) + '/../lib/dot_helper.rb'
require File.dirname(__FILE__) + '/../lib/dijkstra_graph.rb'
require File.dirname(__FILE__) + '/../lib/variable_neighborhood_search.rb'
require File.dirname(__FILE__) + '/../lib/material_flow.rb'

require 'logger'
require 'json'

class DatasetHelper 
  def self.run(dataset_name, facilities, material_flow, neighbours, max_no_improv, max_no_improv_ls)
    fn_logfile = File.dirname(__FILE__) + '/output/dataset.log'
    output_path_pattern = File.dirname(__FILE__) + '/output/' + dataset_name + '_'
    logger = Logger.new(fn_logfile)

    logger.debug("Start " +  dataset_name + " ****************************")
    logger.debug('facilities: ' + facilities.inspect.to_s)
    logger.debug('material_flow: ' + material_flow.inspect.to_s)
    logger.debug('neighbours: ' + neighbours.inspect.to_s)
    logger.debug('max_no_improv: ' + max_no_improv.inspect.to_s)
    logger.debug('max_no_improv_ls: ' + max_no_improv_ls.inspect.to_s)

    t1 = Time.now
    vns = VariableNeighborhoodSearch.new(facilities, material_flow)
    best = vns.search(neighbours,max_no_improv, max_no_improv_ls)
    t2 = Time.now
    initial = vns.initial_layout

    logger.debug('initial.material_flow.facility_map: ' + JSON.generate(initial.material_flow.facility_map.values.map { |e| e.to_hash }))
    logger.debug('initial.facilities: ' +  JSON.generate(initial.facilities.map { |e| e.to_hash }))
    logger.debug('initial.silicing_order: ' + initial.silicing_order.inspect.to_s)
    logger.debug('initial.orientation: ' + initial.orientation.inspect.to_s)
    logger.debug('best.material_flow.facility_map: ' + JSON.generate(best.material_flow.facility_map.values.map { |e| e.to_hash }))
    logger.debug('best.facilities: ' +  JSON.generate(best.facilities.map { |e| e.to_hash }))
    logger.debug('best.silicing_order: ' + best.silicing_order.inspect.to_s)
    logger.debug('best.orientation: ' + best.orientation.inspect.to_s)
    logger.debug('vns.iter: ' + vns.iter.inspect.to_s)
    logger.debug('vns.best_iter: ' + vns.best_iter.inspect.to_s)
    logger.debug('initial.material_flow.costs: ' + initial.material_flow.costs.inspect.to_s)
    logger.debug('initial.material_flow.distance: ' + initial.material_flow.distance.inspect.to_s)
    logger.debug('best.material_flow.costs: ' + best.material_flow.costs.inspect.to_s)
    logger.debug('best.material_flow.distance: ' + best.material_flow.distance.inspect.to_s)
    logger.debug('duration: ' + (t2 - t1).to_s)

    s = Hash.new
    s['dataset'] = dataset_name
    s['duration'] = t2-t1
    s['neighbours'] = neighbours
    s['max_no_improv'] = max_no_improv
    s['max_no_improv_ls'] = max_no_improv_ls
    s['iterations'] = vns.iter.inspect
    s['best_iteration'] = vns.best_iter.inspect
    s['initial_costs'] = initial.material_flow.costs
    s['initial_distance'] = initial.material_flow.distance
    s['best_costs'] = best.material_flow.costs
    s['best_distance'] = best.material_flow.distance;
    logger.info(JSON.generate(s));
    logger.debug("Stop  " +  dataset_name + " ****************************")
    SVGHelper.layout_to_svg_file(initial,output_path_pattern + 'initial_layout.svg')
    SVGHelper.layout_to_svg_file(best,output_path_pattern + 'best_layout.svg')

    logger.close


    vns
  end

end

