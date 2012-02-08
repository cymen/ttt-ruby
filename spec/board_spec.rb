require 'board'

describe Board do
  before(:each) do
    @board = Board.new
  end

  it "get should return nil for spaces 1-9 on empty board" do
    (1..9).each do |space|
      @board.get(space).should eq(nil)
    end
  end

  it "get should return :x for spaces 1-9 if spaces set to :x" do
    @board = Board.new [:x, :x, :x, :x, :x, :x, :x, :x, :x]
    (1..9).each do |space|
      @board.get(space).should eq(:x)
    end
  end

  it "empty should return [1, 2, 3, 4, 5, 6, 7, 8, 9] on an empty board" do
    @board.empty.should eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
  end

  it "empty should return [1, 2, 3] on a board in which all spaces except 1, 2 and 3 are set" do
    @board = Board.new [nil, nil, nil, :x, :x, :x, :x, :x, :x]
    (1..3).each do |space|
      @board.empty.should eq([1, 2, 3])
    end
  end

  it "get_row should return [:x, :x, :x] if called with [1, 2, 3] and those spaces are set to :x" do
    @board = Board.new [:x, :x, :x]
    @board.get_row([1, 2, 3]).should eq([:x, :x, :x])
  end

  it "get_rows should return all 8 rows (horizontal, vertical, diagonal) from a board in an array" do
    @board = Board.new [:o, :o, :o, :o, :o, :o, :o, :o, :o]
    rows = @board.get_rows
    rows.kind_of?(Array).should eq(true)
    rows.count.should eq(8)
    rows.each { |row| row.should eq([:o,:o,:o]) }
  end

  it "count :x should return 0 on an empty board" do
    @board.count(:x).should eq(0)
  end

  it "count :x should return 0 on a board of [ :x, :x, :x, nil, ... ]" do
    @board = Board.new [:x, :x, :x]
    @board.count(:x).should eq(3)
  end

end
