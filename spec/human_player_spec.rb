require 'human_player'

describe HumanPlayer do
  it "knows it's play type" do
    HumanPlayer.new(:x).is?(:x).should eq (true)
    HumanPlayer.new(:o).is?(:x).should eq (false)
  end
end
