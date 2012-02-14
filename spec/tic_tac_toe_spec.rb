require 'tic_tac_toe'

describe TicTacToe do
  it "should determine the current turn based on the value of the board spaces" do
    TicTacToe.turn(Board.new).should eq(:x)
    TicTacToe.turn(Board.new [:x]).should eq(:o)
  end
end
