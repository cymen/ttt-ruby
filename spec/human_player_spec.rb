require 'human_player'

describe HumanPlayer do
  it "knows it's play type" do
    HumanPlayer.new(:x).is.should eq (:x)
  end
end
