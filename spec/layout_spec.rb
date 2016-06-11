require 'spec_helper'

describe 'Layout erzeugen' do
  it "Klasse erzeugen" do
    facilities = [2,6,3,4,5,0,1]
    silicing_order = [4,3,2,1,0,5]
    orientation = [0,0,1,1,0]
    l = Layout.new(facilities,silicing_order,orientation)

    expect(l.class).to eq(Layout)
  end
end
