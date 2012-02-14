require 'scorer'

describe Scorer do
  it "correctly identifies if a game is tied" do
    (Scorer.tie? Board.new).should eq(false)
    (Scorer.tie? Board.new [:x,:o,:x,:o,:x,:o,:o,:x,:o]).should eq(true)
  end

  it "can determine if a row is all set to the same value" do
    (Scorer.same_and_not_nil? []).should eq(false)
    (Scorer.same_and_not_nil? [nil, nil, nil]).should eq(false)
    (Scorer.same_and_not_nil? [:x, :x, :x]).should eq(true)
  end

  it "correctly identifies if the game has been won" do
    (Scorer.winner Board.new).should eq(nil)
    (Scorer.winner Board.new [:x, :x, :x]).should eq(:x)
  end

  it "can determine if game is over via tie or it was won" do
    (Scorer.over? Board.new).should eq(false)
    (Scorer.over? Board.new [:x,:x,:x]).should eq(true)
    (Scorer.over? Board.new [:x,:o,:x,:o,:x,:o,:o,:x,:o]).should eq(true)
  end
end
