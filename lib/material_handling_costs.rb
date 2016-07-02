class MaterialHandlingCosts
  attr_reader :layout

  def initialize(layout)
    @layout = layout
  end

  def neighbours
    af = @layout.arranged_facilities
    af.each_with_index do |f1,i|
      if (i + 1 < af.size)
	f2 = af[i + 1] 
	p neighbour_direction(f1, f2)
      end
    end

  end

  def neighbour_direction(f1, f2)
    n = false
    e = false
    w = false
    s = false
    n = true if f1.y1 > f2.y1
    w = true if f2.x1 < f1.x1
    e = true if f1.x1 < f2.x1
    s = true if f2.y1 > f1.y1
    p '---'
    p f1,f2,n,w,e,s
    if n
      if w
	return :nw
      end
      if e 
	return :ne
      end
      return :n
    end
    if s
      if w
	return :sw
      end
      if e 
	return :se
      end
      return :s
    end
    return :e if e
    return :w if w
    nil
  end

end
