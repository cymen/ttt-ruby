require 'tic_tac_toe'

describe TicTacToe do
  it "determines current turn based on board" do
    TicTacToe.turn(Board.new).should eq(:x)
    TicTacToe.turn(Board.new [:x]).should eq(:o)
  end
end
