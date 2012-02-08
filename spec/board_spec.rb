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

  it "gets values initialized with an array" do
    @board = Board.new [:x, :x, :x, :x, :x, :x, :x, :x, :x]
    (1..9).each do |space|
      @board.get(space).should eq(:x)
    end
  end

  it "shows all spaces as empy on an empy board" do
    @board.empty.should eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
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

  it "counts the number of board spaces with a specific value" do
    @board.count(:x).should eq(0)
    @board = Board.new [:x, :x, :x]
    @board.count(:x).should eq(3)
  end

end
