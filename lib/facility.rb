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
  def initialize(id, width, height, feeding=:nil)
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

  def center
    [(@x1 + (@width/2)),(@y1 + (@height/2))]
  end

  def self.distance(f1, f2)
    x1,y1 = f1
    x2,y2 = f2
    Math.sqrt((x1-x2)**2.0 + (y1-y2)**2.0)
  end

  # Quelle:
  # https://github.com/EddM/Liang-Barsky/blob/master/lib/rect.rb
  # Die Funktion wurde so angepasst, dass die Start-/Endpunkte der Linien
  # nicht zum Schnitt fuehren
  # (@x1+1), @y1+1, @x2-1, @y2-1 --> Das Rechteck wird fuer die Betrachtung
  # verkleinert.
  def intersects_line?(x1, y1, x2, y2)
    t0 = 0.0
    t1 = 1.0
    p = q = r = 0.0
    
    x_delta = x2 - x1
    y_delta = y2 - y1
    
    (0..3).each do |edge|
      
      if edge == 0 # left edge
        p = -x_delta
        q = -(@x1 + 1 - x1)
      end
      
      if edge == 1 # right edge
        p = x_delta
        q = (@x2 - 1 - x1)
      end
      
      if edge == 2 # top edge
        p = -(y_delta)
        q = -(@y1 + 1 - y1)
      end
      
      if edge == 3 # bottom edge
        p = y_delta
        q = (@y2 - 1 - y1)
      end

      r = q.to_f / p.to_f

      return false if p == 0 && q < 0 
      
      if p < 0
        if r > t1
          return false
        elsif r > t0
          t0 = r
        end
      elsif p > 0
        if r < t0
          return false
        elsif r < t1
          t1 = r
        end
      end
    end
    
    true
  end

  def to_hash
    hash = {} 
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end
  
end

