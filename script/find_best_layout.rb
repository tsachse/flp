# ruby ./script/find_best_layout.rb doc/160802/dataset-skdas_12_100_1008.log 
#
require 'json'
require File.dirname(__FILE__) + '/../lib/layout.rb'
require File.dirname(__FILE__) + '/../lib/facility.rb'
require File.dirname(__FILE__) + '/../lib/facility_set.rb'
require File.dirname(__FILE__) + '/../lib/svg_helper.rb'

fn_log = ARGV.first
c_min = Float::INFINITY
best_map = initial_map = ''
best_map_min = initial_map_min = ''

File.open(fn_log, "r") do |f|
  f.each_line do |line|
    #puts line
    if (line =~ /.+initial.material_flow.facility_map:\s(.+)$/)
      initial_map = $1
    end
    if (line =~ /.+best.material_flow.facility_map:\s(.+)$/)
      best_map = $1
    end
    if (line =~ /.+best.material_flow.costs:\s(\d+)/)
      c = $1.to_f
      if c < c_min
	c_min = c
	initial_map_min = initial_map
	best_map_min = best_map
      end
    end
  end
end

puts c_min
# puts initial_map_min
# puts best_map_min

ofn_pattern = fn_log + ".#{c_min.round.to_s}"
fn_best = ofn_pattern + '.best.svg'
fn_initial = ofn_pattern + '.initial.svg'
puts fn_best
puts fn_initial
SVGHelper.json_to_svg_file(initial_map_min,fn_initial)
SVGHelper.json_to_svg_file(best_map_min,fn_best)
