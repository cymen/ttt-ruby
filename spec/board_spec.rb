require 'board'

describe Board do
  before(:each) do
    @board = Board.new
  end

  it "returns a hash of spaces" do
    @board.spaces.class.should eq(Hash)
  end

  it "returns a hash with 9 entries" do
    @board.spaces.keys.count.should eq(9)
  end

  it "returns a hash with 9 entries all nil" do
    @board.spaces.each_with_index do |value, key|
      @board.spaces[key].should eq(nil)
    end
  end

  it "returns an :x if hash entry set to :x" do
    @board.spaces.keys.each do |key|
      @board.spaces[key] = :x
    end
    @board.spaces.values.each do |value|
      value.should eq(:x)
    end
  end

  it "returns an array of all :x if all spaces are :x and get(indexes) is run" do
    @board.spaces.keys.each do |key|
      @board.spaces[key] = :x
    end
    @board.get([1, 2, 3]).should eq([:x, :x, :x])
  end

  it "empty on a blank board returns an array containing all square numbers" do
    @board.empty.should eq ([1, 2, 3, 4, 5, 6, 7, 8, 9])
  end

  it "empty on a blank board except space 1 being :x should return array containing 2-9" do
    @board.spaces[1] = :x
    @board.empty.should eq ([2, 3, 4, 5, 6, 7, 8, 9])
  end
end
