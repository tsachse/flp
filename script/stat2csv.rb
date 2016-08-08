# ruby ./script/stat2csv.rb doc/160802/dataset-skdas_12_100_1008.log 
#
require 'json'
require File.dirname(__FILE__) + '/../lib/layout.rb'
require File.dirname(__FILE__) + '/../lib/facility.rb'
require File.dirname(__FILE__) + '/../lib/facility_set.rb'
require File.dirname(__FILE__) + '/../lib/svg_helper.rb'

stat = []

fn_log = ARGV.first
fn_csv = fn_log + '.csv'

File.open(fn_log, "r") do |f|
  f.each_line do |line|
    #puts line
    if (line =~ /.+INFO\s--\s:\s(\{.+\})$/)
      json_stat = $1
      stat << JSON.parse(json_stat)
    end
  end
end

csv = File.open(fn_csv,"w")
fields =  stat.first.keys
csv.puts fields.join(',')
stat.each do |s|
  a = []
  fields.each do |f|
    a << s[f]
  end
  csv.puts a.join(',')
end
csv.close

