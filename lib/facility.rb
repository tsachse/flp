class Facility
  attr_reader :id
  attr_reader :width
  attr_reader :height

  def initialize(id, width, height)
    @id = id
    @width = width
    @height = height
  end

end

