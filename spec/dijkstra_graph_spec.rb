require 'spec_helper'

describe DijkstraGraph do
  it "new instance" do
    g = DijkstraGraph.new([ [:a, :b, 7],
			    [:a, :c, 9],
			    [:a, :f, 14],
			    [:b, :c, 10],
			    [:b, :d, 15],
			    [:c, :d, 11],
			    [:c, :f, 2],
			    [:d, :e, 6],
			    [:e, :f, 9],
			  ])
     
    expect(g.class).to eq(DijkstraGraph)
    start, stop = :a, :e
    40.times do
      path, dist = g.shortest_path(start, stop) 
      expect(dist).to eq(20)
      expect(path).to eq([:a, :c, :f, :e])
    end
  end

end
