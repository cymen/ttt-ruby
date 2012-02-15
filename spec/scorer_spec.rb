require 'scorer'

describe Scorer do
  it "identifies tied game" do
    (Scorer.tie? Board.new).should eq(false)
    (Scorer.tie? Board.new [:x,:o,:x,:o,:x,:o,:o,:x,:o]).should eq(true)
  end

  it "can check if row has each space with same value" do
    (Scorer.same_and_not_nil? []).should eq(false)
    (Scorer.same_and_not_nil? [nil, nil, nil]).should eq(false)
    (Scorer.same_and_not_nil? [:x, :x, :x]).should eq(true)
  end

  it "identifies won games" do
    (Scorer.winner Board.new).should eq(nil)
    (Scorer.winner Board.new [:x, :x, :x]).should eq(:x)
  end

  it "identifies finished (tied or won) games" do
    (Scorer.over? Board.new).should eq(false)
    (Scorer.over? Board.new [:x,:x,:x]).should eq(true)
    (Scorer.over? Board.new [:x,:o,:x,:o,:x,:o,:o,:x,:o]).should eq(true)
  end
end
