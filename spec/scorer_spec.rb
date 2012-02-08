require 'scorer'

describe Scorer do
  it "tie? should be false on an empty board" do
    (Scorer.tie? Board.new).should eq(false)
  end
  
  it "same_and_not_nil? [] should return false" do
    (Scorer.same_and_not_nil? []).should eq(false)
  end

  it "same_and_not_nil? [nil, nil, nil] should return false" do
    (Scorer.same_and_not_nil? [nil, nil, nil]).should eq(false)
  end

  it "same_and_not_nil? [:x, :x, :x] should return true" do
    (Scorer.same_and_not_nil? [:x, :x, :x]).should eq(true)
  end

  it "winner on empty board should return nil" do
    (Scorer.winner Board.new).should eq(nil)
  end

  it "winner on board [ :x, :x, :x, nil ... ] should return :x" do
    (Scorer.winner Board.new [:x, :x, :x]).should eq(:x)
  end

end
