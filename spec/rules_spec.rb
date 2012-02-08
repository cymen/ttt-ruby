require 'rules'

describe Rules do
  it "should determine the current turn based on the value of the board spaces" do
    Rules.turn(Board.new).should eq(:x)
    Rules.turn(Board.new [:x]).should eq(:o)
  end
end
