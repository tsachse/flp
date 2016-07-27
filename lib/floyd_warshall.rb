require 'matrix'

#class Matrix
#  def []=(i, j, x)
#    @rows[i][j] = x
#  end
#end

class FloydWarshall
  attr_reader :edges
  attr_reader :bidirectional
  attr_accessor :matrix
  attr_reader :short
  attr_reader :vertex_map

  def initialize(edges, bidirectional = false)
    @edges = edges
    @bidirectional = bidirectional
    if edges != nil
      build_matrix 
      warshall
    end
  end

  def build_matrix
    i = 0
    @vertex_map = {}
    @edges.each do |e|
      start, stop, dist = e
      if ! @vertex_map.has_key?(start)
	@vertex_map[start] = i
	i = i + 1
      end
      if ! @vertex_map.has_key?(stop)
	@vertex_map[stop] = i
	i = i + 1
      end
    end

    matrix = Matrix.build(i, i) {|row, col| -1 }.to_a
    @edges.each do |e|
      start, stop, dist = e
      matrix[@vertex_map[start]][@vertex_map[stop]] = dist
      matrix[@vertex_map[stop]][@vertex_map[start]] = dist if @bidirectional
    end
    @matrix = Matrix.rows(matrix)
  end

  def shortest_distance(start,stop)
    # TODO: Exception? "dist: f1_ f4_w"
    p "dist: #{start} #{stop}" if start == nil || stop == nil || @vertex_map[start] == nil || @vertex_map[stop] == nil
    @short[@vertex_map[start],@vertex_map[stop]]
  end

  def dist(start,stop)
    shortest_distance(start,stop)
  end

 
  def self.show(matrix)
    matrix.each_slice(matrix.column_count){|e| puts e.join(" ")}
  end
 
  def warshall
    raise "No a valid square" unless @matrix.square?
    n = @matrix.column_count
    i = Float::INFINITY
    short = Matrix.build(n){ i }.to_a
    n.times do |x|
      n.times do |y|
        short[x][y] = @matrix[x, y] if @matrix[x, y] > -1
      end
      short[x][x] = 0
    end
 
    n.times do |z|
      n.times do |x|
        n.times do |y|
          short[x][y] = [short[x][y], short[x][z] + short[z][y]].min
        end
      end
    end
 
    @short = Matrix.rows(short)
  end
 
end
