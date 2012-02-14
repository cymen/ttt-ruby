require 'computer_player'

RSpec::Matchers.define :should_be_in do |choice|
  match do |actual|
    actual.count choice > 0
  end
  failure_message_for_should do |actual|
    "expected that #{choice} would be in #{actual}"
  end
end



describe ComputerPlayer do
  it "it is what it is initialized to" do
    ComputerPlayer.new(:o).is.should eq(:o)
  end

  it "knows optimal choices for an empty board" do
    ComputerPlayer.new(:x).optimal_choices_on_empty_board.should eq([1, 3, 5, 7, 9])
  end

  it "can filter hash of space => weight choices to array of optimal choices" do
    ComputerPlayer.new(:x).filter_weighted_choices_to_best({ 1 => 10, 2 => 3, 3 => 10 }).should eq([1, 3])
    ComputerPlayer.new(:o).filter_weighted_choices_to_best({ 1 => 5, 2 => 10, 3 => 5 }).should eq([2])
  end

  it "can choose a random choice from an array of choices" do
    ComputerPlayer.new(:x).
  end

end
