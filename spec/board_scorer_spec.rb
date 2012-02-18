require 'board'

describe Board do
  it "identifies tied game" do
    Board.new.tie?.should eq(false)
    Board.new([:x,:o,:x,:o,:x,:o,:o,:x,:o]).tie?.should eq(true)
  end

  it "can check if row has each space with same value" do
    board = Board.new
    board.same_and_not_nil?([]).should eq(false)
    board.same_and_not_nil?([nil, nil, nil]).should eq(false)
    board.same_and_not_nil?([:x, :x, :x]).should eq(true)
  end

  it "identifies won games" do
    Board.new.winner.should eq(nil)
    Board.new([:x,:x,:x]).winner.should eq(:x)
  end

  it "identifies finished (tied or won) games" do
    Board.new.over?.should eq(false)
    Board.new([:x,:x,:x]).over?.should eq(true)
    Board.new([:x,:o,:x,:o,:x,:o,:o,:x,:o]).over?.should eq(true)
  end
end
