class Layout
  attr_reader :facilities
  attr_reader :silicing_order
  attr_reader :orientation

  def initialize(facilities, silicing_order, orientation)
    @facilities = facilities
    @silicing_order = silicing_order
    @orientation = orientation
  end
end
