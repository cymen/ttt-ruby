require 'negamax'
require 'rspec/expectations'

RSpec::Matchers.define :have_optimal_move_of do |expected|
  match do |actual|
    (actual.max_by {|_, value| value }).first == expected and actual.values.count(actual.values.max) == 1
  end
  failure_message_for_should do |actual|
    "expected that #{actual.to_s} max value should key equal to #{expected} and be only one w/ value!"
  end
end

RSpec::Matchers.define :have_optimal_moves_of do |expected|
  match do |actual|
    max = actual.values.max
    actual.select {|_, value| value == max }.keys.sort == expected.sort
  end
  failure_message_for_should do |actual|
    "expected that #{actual.to_s} max value should keys equal #{expected}"
  end
end

RSpec::Matchers.define :not_have_choice_of do |unexpected|
  match do |actual|
    actual.keys.count unexpected == 0
  end
  failure_message_for_should do |actual|
    "expected that #{actual} should not have a key of #{unexpected}"
  end
end

describe Negamax do
  it "sorts choices to put known optimal first" do
    choices = Negamax.new.sort_choices_optimally([1,2,3,4,5,6,7,8,9])
    choices.slice(0, Negamax::Optimal.count).sort.should eq(Negamax::Optimal)
  end

  it "analyzes tied game" do
    negamax = Negamax.new
    Negamax.new.analysis(Board.new([:x,:o,:x,:o,:x,:o,:o,:x,:o]), 1).should eq(0)
  end

  it "analyzes won game" do
    Negamax.new.analysis(Board.new([:x,:o,nil,:x,:o,nil,:x]), 1).should eq((2 ** -1) * -1)
  end

  it "doesn't pick an obvious loose" do
    Negamax.new.run(Board.new([:x,nil,nil,nil,:o])).should not_have_choice_of 9
  end

  it "picks a fork" do
    Negamax.new.run(Board.new([:x,nil,:o])).should have_optimal_moves_of [4, 7, 9]
  end

  it "picks a win over a block" do
    Negamax.new.run(Board.new([:x,:x,:o,:x,:x,:o,:o])).should have_optimal_move_of 9
  end

  it "picks immediate win" do
    Negamax.new.run(Board.new([:x,nil,:x,nil,nil,nil,:o,nil,:o])).should have_optimal_move_of 2
  end

  it "forces other player to react to it's move instead of defending" do
    Negamax.new.run(Board.new([:x,nil,:x,nil,nil,nil,:o])).should have_optimal_move_of 2
  end

  it "picks a block of opposing player" do
    Negamax.new.run(Board.new([:x,nil,:o,nil,:x,nil,nil,nil,nil])).should have_optimal_move_of 9
    Negamax.new.run(Board.new([:x,nil,:o,nil,nil,nil,:x])).should have_optimal_move_of 4
  end

  it "picks a corner that both is a long term block and a long term possible win" do
    Negamax.new.run(Board.new([:x,nil,:o,:o,nil,nil,:x])).should have_optimal_move_of 9
  end

  #it "choose spaces 1, 3, 5, 7 and 9 as most optimal on an empty board" do
  #  Negamax.new.run(Board.new).should have_optimal_moves_of [1, 3, 5, 7, 9]
  #end
end
