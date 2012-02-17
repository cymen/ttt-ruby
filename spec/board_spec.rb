require 'board'

describe Board do
  before(:each) do
    @board = Board.new
  end

  it "gets empty spaces" do
    (1..9).each do |space|
      @board.get(space).should eq(nil)
    end
  end

  it "sees empty board as empty" do
    @board.empty?.should eq(true)
  end

  it "does not see a non-empty board as empty" do
    @board = Board.new [:x]
    @board.empty?.should eq(false)
  end

  it "gets values initialized with an array" do
    @board = Board.new [:x, :x, :x, :x, :x, :x, :x, :x, :x]
    (1..9).each do |space|
      @board.get(space).should eq(:x)
    end
  end

  it "shows all spaces as empty on an empty board" do
    @board.empty.should eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
  end

  it "can set a space to a value and then clear it back to nil" do
    @board.get(1).should eq(nil)
    @board.set(1, :x).should eq(:x)
    @board.clear(1)
    @board.get(1).should eq(nil)
  end

  it "can return a hash of the spaces which is a copy" do
    @board = Board.new [:x]
    spaces = @board.get_all_spaces
    @board.get(1).should eq(:x)
    spaces[1] = :o
    @board.get(1).should eq(:x)
  end

  it "shows only some spaces empty on a partially empty board" do
    @board = Board.new [nil, nil, nil, :x, :x, :x, :x, :x, :x]
    (1..3).each do |space|
      @board.empty.should eq([1, 2, 3])
    end
  end

  it "shows the correct values for a row that is retrieved from the board" do
    @board = Board.new [:x, :x, :x]
    @board.get_row([1, 2, 3]).should eq([:x, :x, :x])
  end

  it "shows all the rows for the board" do
    @board = Board.new [:o, :o, :o, :o, :o, :o, :o, :o, :o]
    rows = @board.get_rows
    rows.kind_of?(Array).should eq(true)
    rows.count.should eq(8)
    rows.each { |row| row.should eq([:o,:o,:o]) }
  end

  it "provides set of horizontal row index set" do
    set = @board.get_horizontal_row_index_sets
    set.kind_of?(Array).should eq(true)
    set.count.should be > 0
  end

  it "returns length of a side" do
    @board.side_length.should be > 0
  end

  it "counts number of spaces on an empty board" do
    @board.count.should eq(@board.side_length ** 2)
  end

  it "counts the number of board spaces with a specific value" do
    @board.count(:x).should eq(0)
    @board = Board.new [:x, :x, :x]
    @board.count(:x).should eq(3)
  end

end
