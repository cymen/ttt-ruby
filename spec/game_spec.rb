require 'game'

describe Game do
  it "should determine the current turn based on the value of the board spaces" do
    Game.turn(Board.new).should eq(:x)
    Game.turn(Board.new [:x]).should eq(:o)
  end
  
  it "correctly identifies if a game is tied" do
    (Game.tie? Board.new).should eq(false)
    (Game.tie? Board.new [:x,:o,:x,:o,:x,:o,:o,:x,:o]).should eq(true)
  end

  it "can determine if a row is all set to the same value" do
    (Game.same_and_not_nil? []).should eq(false)
    (Game.same_and_not_nil? [nil, nil, nil]).should eq(false)
    (Game.same_and_not_nil? [:x, :x, :x]).should eq(true)
  end

  it "correctly identifies if the game has been won" do
    (Game.winner Board.new).should eq(nil)
    (Game.winner Board.new [:x, :x, :x]).should eq(:x)
  end

  it "can determine if game is over via tie or it was won" do
    (Game.over? Board.new).should eq(false)
    (Game.over? Board.new [:x,:x,:x]).should eq(true)
    (Game.over? Board.new [:x,:o,:x,:o,:x,:o,:o,:x,:o]).should eq(true)
  end

end
