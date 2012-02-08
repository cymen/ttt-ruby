require 'scorer'

describe Scorer do
  before(:each) do
    @board = Board.new
    @scorer = Scorer.new
  end

  it "game_over? returns false by default" do
    @scorer.game_over?(@board).should eq(false)
  end

  it "game_over? returns true if no empty spaces left" do
    @board.spaces[1] = :x
    @board.spaces[2] = :o
    @board.spaces[3] = :x
    @board.spaces[4] = :o
    @board.spaces[5] = :x
    @board.spaces[6] = :o
    @board.spaces[7] = :o
    @board.spaces[8] = :x
    @board.spaces[9] = :o
    @scorer.game_over?(@board).should eq([true, :tie])
  end

  it "game_over? returns true, :x if the first row is all :x" do
    (1..3).each do |key|
      @board.spaces[key] = :x
    end
    @board.spaces[1].should eq(:x)
    @board.spaces[2].should eq(:x)
    @board.spaces[3].should eq(:x)
    @board.get([1,2,3]).should eq([:x,:x,:x])
    @scorer.game_over?(@board).should eq([true, :x])
  end

  it "game_over? returns true, :o if the first column is all :o" do
    [1, 4, 7].each do |key|
      @board.spaces[key] = :o
    end
    @scorer.game_over?(@board).should eq([true, :o])
  end
end
