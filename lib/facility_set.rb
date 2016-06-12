require 'facility'

class FacilitySet
  attr_reader :facilities
  attr_reader :width
  attr_reader :height
  attr_accessor :x1
  attr_accessor :y1
  attr_accessor :x2
  attr_accessor :y2

  def initialize(facilities)
    @facilities = facilities
    @width = @height = 0
    @facilities.each do |f|
      @width = @width + f. width
      @height = @height + f.height
    end
  end

  def size
    @facilities.size
  end

  def grep(e)
    @facilities.grep(e)
  end

end

