require 'minimax'

describe Minimax do
  it ":o should pick space 9 in order to win the game" do
    board = Board.new [ :x, :x, :o, :x, :x, :o, :o, nil, nil ]
    minimax = Minimax.new :o
    result = minimax.run board
    #puts result.to_s
    (result.max_by { |key, value| value }).first.should eq(9)
  end

  it ":x should pick space 2 in order to win the game" do
    board = Board.new [ :x, nil, :x, nil, nil, nil, :o, nil, :o ]
    minimax = Minimax.new :x
    result = minimax.run board
    #puts result.to_s
    (result.max_by { |key, value| value }).first.should eq(2)
  end

  it ":o should pick space 2 in order to block :x from winning" do
    board = Board.new [ :x, nil, :x, nil, nil, nil, :o, nil, nil ]
    minimax = Minimax.new :o
    result = minimax.run board
    puts result.to_s
    (result.max_by { |key, value| value }).first.should eq(2)
  end

#  it "something should happen but not sure what" do
#    board = Board.new
#    minimax = Minimax.new :x
#    result = minimax.run board
#    puts "result: " + result.to_s
#  end

end
