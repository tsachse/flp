require 'spec_helper'

describe FloydWarshall do
  it "new instance" do

    m = Matrix[
      [0,4,0,0],
      [0,0,2,0],
      [0,0,0,2],
      [2,0,0,0]
    ]
    

    f = FloydWarshall.new(nil)
    f.matrix = m
    f.warshall
     
    expect(f.class).to eq(FloydWarshall)

    p FloydWarshall.show f.matrix
    p FloydWarshall.show f.short
  end

  it "test distance" do
    e = [ 
      [:a, :b, 7],
      [:a, :c, 9],
      [:a, :f, 14],
      [:b, :c, 10],
      [:b, :d, 15],
      [:c, :d, 11],
      [:c, :f, 2],
      [:d, :e, 6],
      [:e, :f, 9],
    ]
    f = FloydWarshall.new(e)
    f.build_matrix
    p FloydWarshall.show f.matrix
    p f.dist(:a,:e)

  end

end
