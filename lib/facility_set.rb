require 'facility'

class FacilitySet
  attr_reader :facilities
  attr_reader :width
  attr_reader :height
  attr_accessor :x1
  attr_accessor :y1
  attr_accessor :x2
  attr_accessor :y2

  def initialize(facilities, x1 = 0, y1 = 0)
    @facilities = facilities
    @x1 = x1
    @y1 = y1
    @width = @height = 0
    @facilities.each do |f|
      @width = @width + f. width
      @height = @height + f.height
    end
  end

  def can_cut?(id)
    return false if @facilities.size < 2
    return (@facilities.find { |f| f.id == id }) != nil
  end

  def cut_facilities(id)
    first_set = true
    two_sets = @facilities.partition do |f|
      s = first_set
      first_set = false if f.id == id
      s
    end
  end

  def facility_ids
    @facilities.map { |f| f.id }
  end

  def label
    facility_ids.join('-')
  end

end

