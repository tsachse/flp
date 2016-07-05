class DotHelper
  def self.edges_to_dot_file(edges, material_flow, filename)
    File.open(filename, "w") do |f|
      f.puts "digraph edges {"
      material_flow.flatten.uniq do |n|
	f.puts "  #{n} [ style=filled, color=\"green\" ]"
      end
      edges.each do |e|
	f.puts "  #{e[0]} -> #{e[1]} [label=\"#{e[2]}\"]"
      end
      f.puts "}"
    end
  end
end
