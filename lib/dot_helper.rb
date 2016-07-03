class DotHelper
  def self.edges_to_dot_file(edges, filename)
    File.open(filename, "w") do |f|
      f.puts "digraph edges {"
      edges.each do |e|
	f.puts "  #{e[0]} -> #{e[1]} [label=\"#{e[2]}\"]"
      end
      f.puts "}"
    end
  end
end
