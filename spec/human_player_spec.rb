require 'human_player'

describe HumanPlayer do
  it "it is what it is initialized to" do
    HumanPlayer.new(:x).is.should eq (:x)
  end
end
