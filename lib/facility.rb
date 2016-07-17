class Facility
  attr_reader :id
  attr_reader :width
  attr_reader :height
  attr_accessor :feeding
  attr_accessor :x1
  attr_accessor :y1
  attr_accessor :x2
  attr_accessor :y2

  # TODO: Parameter feeding spaeter entsorgen
  def initialize(id, width, height, feeding=:w)
    @id = id
    @width = width
    @height = height
    @x1 = 0
    @y1 = 0
    @x2 = @x1 + width
    @y2 = @y1 + height
    @feeding = feeding
  end

  def north
    [(@x1 + (@width/2)),@y1]
  end

  def west
    [@x1, (@y1 + (@height/2))]
  end

  def south
    [(@x1 + (@width/2)),@y2]
  end

  def east
    [@x2, (@y1 + (@height/2))]
  end

  def self.distance(f1, f2)
    x1,y1 = f1
    x2,y2 = f2
    Math.sqrt((x1-x2)**2.0 + (y1-y2)**2.0)
  end

end

