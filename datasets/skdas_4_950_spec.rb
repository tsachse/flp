require File.dirname(__FILE__) + '/../spec/spec_helper'
require 'logger'

describe Layout do
  before(:all) do
    fn_logfile = File.dirname(__FILE__) + '/output/skdas.log'
    @logger = Logger.new(fn_logfile)
    @output_path_pattern = File.dirname(__FILE__) + '/output/' + File.basename(__FILE__) + '_'
  end

  before(:each) do
    @f1 = Facility.new(:f1, 18, 10)
    @f2 = Facility.new(:f2,  9,  5)
    @f3 = Facility.new(:f3, 10, 10)
    @f4 = Facility.new(:f4, 20, 15)
    @facilities = [@f1,@f2,@f3,@f4]

    @material_flow = [
      [:f1, :f2, 20],
      [:f1, :f3, 30],
      [:f1, :f4, 15],
      [:f2, :f3,  5],
      [:f2, :f4, 38],
      [:f3, :f4, 12]
    ]
  end

  after(:all) do
    @logger.close
  end

  it "4 Facilities - 950 Neighbours" do
    @logger.info("Start " +  File.basename(__FILE__) + " ****************************")
    @logger.info('@facilities: ' + @facilities.inspect.to_s)
    @logger.info('@material_flow: ' + @material_flow.inspect.to_s)

    vns = VariableNeighborhoodSearch.new(@facilities, @material_flow)
    neighbours = 1..950
    max_no_improv = 10
    max_no_improv_ls = 10

    @logger.info('neighbours: ' + neighbours.inspect.to_s)
    @logger.info('max_no_improv: ' + max_no_improv.inspect.to_s)
    @logger.info('max_no_improv_ls: ' + max_no_improv_ls.inspect.to_s)

    best = vns.search(neighbours,max_no_improv, max_no_improv_ls)
    expect(vns.class).to eq(VariableNeighborhoodSearch)

    initial = vns.initial_layout
    @logger.info('vns.iter: ' + vns.iter.inspect.to_s)
    @logger.info('vns.best_iter: ' + vns.best_iter.inspect.to_s)
    @logger.info('initial.material_flow.costs: ' + initial.material_flow.costs.inspect.to_s)
    @logger.info('initial.material_flow.costs: ' + initial.material_flow.costs.inspect.to_s)
    @logger.info('initial.material_flow.distance: ' + initial.material_flow.distance.inspect.to_s)
    @logger.info('initial.material_flow.facility_map: ' + initial.material_flow.facility_map.inspect.to_s)
    @logger.info('best.material_flow.costs: ' + best.material_flow.costs.inspect.to_s)
    @logger.info('best.material_flow.distance: ' + best.material_flow.distance.inspect.to_s)
    @logger.info('best.material_flow.facility_map: ' + best.material_flow.facility_map.inspect.to_s)

    SVGHelper.layout_to_svg_file(initial,@output_path_pattern + 'initial_layout.svg')
    SVGHelper.layout_to_svg_file(best,@output_path_pattern + 'best_layout.svg')

    @logger.info("Stopp " +  File.basename(__FILE__) + " ****************************")

  end

end
