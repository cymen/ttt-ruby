require 'console_printer'
require 'board'
require 'test/unit'

# tests
class ConsolePrinterTest < Test::Unit::TestCase
  def setup
    @writer = MockWriter.new
  end

  def test_print_board
    ConsolePrinter.print_board Board.new([:x,:o,nil,:o]), @writer
    assert_equal 0, @writer.times_display_blank_line
    assert_equal 0, @writer.times_display_banner_text
    assert_equal 0, @writer.times_display_centered_text
    assert_equal 1, @writer.times_display_board
  end
end


# mocks
class ConsolePrinterTest
  class MockWriter
    attr_accessor :times_display_blank_line, :times_display_banner_text,
      :times_display_centered_text, :times_display_board

    def initialize
      self.times_display_blank_line = 0
      self.times_display_banner_text = 0
      self.times_display_centered_text = 0
      self.times_display_board = 0
    end
  
    def display_blank_line
      self.times_display_blank_line += 1
    end

    def display_banner_text text
      self.times_display_banner_text += 1
    end

    def display_centered_text text
      self.times_display_centered_text += 1
    end

    def display_board board
      self.times_display_board += 1
    end
  end
end
