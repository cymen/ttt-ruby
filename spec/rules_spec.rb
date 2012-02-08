require 'rules'

describe Rules do
  before(:each) do
    @rules = Rules.new
  end

  it "turn should return :x on an empty board" do
    @rules.turn(Board.new).should eq(:x)
  end
end
