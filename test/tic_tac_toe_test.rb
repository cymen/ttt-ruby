require 'tic_tac_toe'
require 'board'
require 'test/unit'

# tests
class TicTacToeTest < Test::Unit::TestCase
  def test
   
  end
end

# mocks
class TicTacToeTest
  class MockTicTacToe
    attr_accessor :times_print_start, :times_print_end,
      :times_ask_human_x_or_o, :times_play_again

    def initialize
      self.times_print_start = 0
      self.times_print_end = 0
      self.times_ask_human_x_or_o = 0
      self.times_play_again = 0
    end

    def print_start
      self.times_print_start += 1
    end

    def print_end board
      self.times_print_end += 1
    end

    def ask_human_x_or_o
      self.times_ask_human_x_or_o += 1
    end

    def play_again
      self.times_play_again += 1
    end
  end
end
