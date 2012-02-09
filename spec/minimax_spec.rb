require 'minimax'
require 'rspec/expectations'

RSpec::Matchers.define :have_optimal_space_of do |expected|
  match do |actual|
    (actual.max_by { |key, value| value }).first == expected
  end
  failure_message_for_should do |actual|
    "expected that #{actual.to_s} max value should key equal to #{expected}"
  end
end


describe Minimax do
  it "picks a win over a block" do
    (Minimax.run Board.new [:x,:x,:o,:x,:x,:o,:o,nil,nil]).should have_optimal_space_of 9
  end

  it "picks immediate win" do
    (Minimax.run Board.new [:x,nil,:x,nil,nil,nil,:o,nil,:o]).should have_optimal_space_of 2
  end

  it "picks a block of opposing player" do
    (Minimax.run Board.new [:x,nil,:x,nil,nil,nil,:o,nil,nil]).should have_optimal_space_of 2 
  end


#  # long running test: all spaces are 0
#  it "something should happen but not sure what" do
#    result = Minimax.run Board.new
#    puts "result: " + result.to_s
#  end
#
end
