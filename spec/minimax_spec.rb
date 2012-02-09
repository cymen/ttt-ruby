require 'minimax'
require 'rspec/expectations'

RSpec::Matchers.define :have_optimal_move_of do |expected|
  match do |actual|
    (actual.max_by { |key, value| value }).first == expected and actual.values.count(actual.values.max) == 1
  end
  failure_message_for_should do |actual|
    "expected that #{actual.to_s} max value should key equal to #{expected} and be only one w/ value!"
  end
end

RSpec::Matchers.define :have_optimal_moves_of do |expected|
  match do |actual|
    actual.reject { |key, value| value != actual.values.max }.keys.sort == expected.sort
  end
  failure_message_for_should do |actual|
    "expected that #{actual.to_s} max value should keys equal #{expected}"
  end
end

RSpec::Matchers.define :have_as_a_choice do |not_expected|
  match do |actual|
    actual.keys.count not_expected == 0
  end
  failure_message_for_should do |actual|
    "expected that #{actual.to_s} should not have key #{not_expected}"
  end
end


describe Minimax do
  it "picks a fork" do
    (Minimax.run Board.new [:x,nil,:o]).should have_optimal_moves_of [7, 9]
  end

  it "picks a win over a block" do
    (Minimax.run Board.new [:x,:x,:o,:x,:x,:o,:o,nil,nil]).should have_optimal_move_of 9
  end

  it "picks immediate win" do
    (Minimax.run Board.new [:x,nil,:x,nil,nil,nil,:o,nil,:o]).should have_optimal_move_of 2
  end

  it "picks a block of opposing player" do
    (Minimax.run Board.new [:x,nil,:x,nil,nil,nil,:o,nil,nil]).should have_optimal_move_of 2
    (Minimax.run Board.new [:x,nil,:o,nil,nil,nil,:x,nil,nil]).should have_optimal_move_of 4
  end

  it "picks a corner that both is a long term block and a long term possible win" do
    (Minimax.run Board.new [:x,nil,:o,:o,nil,nil,:x,nil,nil]).should have_optimal_move_of 9
  end

#  # long running test: all spaces are 0
#  it "something should happen but not sure what" do
#    result = Minimax.run Board.new
#    puts "result: " + result.to_s
#  end

end
