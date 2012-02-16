require 'tic_tac_toe_helper'

describe TicTacToeHelper do
  before(:each) do
    class TicTacToeHelperTester
      include TicTacToeHelper
    end
  end

  it "returns the two player symbols" do
    players = TicTacToeHelperTester.new.get_players
    players.count.should eq(2)
    players.uniq.count.should eq(2)
  end

  it "determines current turn based on board" do
    TicTacToeHelperTester.new.turn(Board.new).should eq(:x)
    TicTacToeHelperTester.new.turn(Board.new [:x]).should eq(:o)
  end
end
