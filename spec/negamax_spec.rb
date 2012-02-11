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
  it "doesn't pick an obvious loose" do
    (Negamax.run Board.new [:x,nil,nil,nil,:o]).should not_have_choice_of 9
  end

  it "picks a fork" do
    (Negamax.run Board.new [:x,nil,:o]).should have_optimal_moves_of [4, 7, 9]
  end

  it "picks a win over a block" do
    (Negamax.run Board.new [:x,:x,:o,:x,:x,:o,:o]).should have_optimal_move_of 9
  end

  it "picks immediate win" do
    (Negamax.run Board.new [:x,nil,:x,nil,nil,nil,:o,nil,:o]).should have_optimal_move_of 2
  end

  it "forces other player to react to it's move instead of defending" do
    (Negamax.run Board.new [:x,nil,:x,nil,nil,nil,:o]).should have_optimal_move_of 2
  end

  it "picks a block of opposing player" do
  #  (Negamax.run Board.new [:x,nil,:o,nil,:x,nil,nil,nil,nil]).should have_optimal_move_of 9
    (Negamax.run Board.new [:x,nil,:o,nil,nil,nil,:x]).should have_optimal_move_of 4
  end

  it "picks a corner that both is a long term block and a long term possible win" do
    (Negamax.run Board.new [:x,nil,:o,:o,nil,nil,:x]).should have_optimal_move_of 9
  end

#  # long running test: all spaces are 0
#  it "something should happen but not sure what" do
#    result = Negamax.run Board.new
#    puts "result: " + result.to_s
# end

end
