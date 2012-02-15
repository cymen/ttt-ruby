require 'tic_tac_toe_turn'

describe TicTacToeTurn do
  it "determines current turn based on board" do
    class TicTacToeTurnTester
      include TicTacToeTurn
    end
    TicTacToeTurnTester.new.turn(Board.new).should eq(:x)
    TicTacToeTurnTester.new.turn(Board.new [:x]).should eq(:o)
  end
end
