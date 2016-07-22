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
      [:e, :f, 9]
    ]
    
    f = FloydWarshall.new(e,true)
    # f.build_matrix
    # f.warshall
    expect(f.dist(:a,:b)).to eq(7)
    expect(f.dist(:a,:c)).to eq(9)
    expect(f.dist(:a,:e)).to eq(20)
    expect(f.dist(:a,:d)).to eq(20)

  end

end
