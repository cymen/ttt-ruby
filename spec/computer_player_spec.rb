require 'computer_player'

RSpec::Matchers.define :be_in do |choices|
  match do |choice|
    choices.count choice > 0
  end
  failure_message_for_should do |choices|
    "expected that #{choice} would be in #{choices}"
  end
end

describe ComputerPlayer do
  it "knows it's play type" do
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
    array = [1, 2, 3, 4, 5]
    ComputerPlayer.new(:x).random_choice_from(array).should be_in(array)
  end

  it "can choose a random best from hash of space => weight choices" do
    ComputerPlayer.new(:x).random_best_from({ 1 => 10, 2 => 3, 3 => 9, 4 => 10, 5 => 6, 6 => 10 }).should be_in([1, 4, 6])
  end

end
