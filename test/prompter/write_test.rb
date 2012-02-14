require 'prompter'
require 'test/unit'
require 'stringio'

class PrompterWriteTest < Test::Unit::TestCase
  def setup
    @stream = StringIO.new
    @writer = Prompter::Writer
  end
  
  def test_ask_for_int
    @writer.ask_for_int @stream
    @stream.rewind
    refute @stream.read.empty?
  end
  
  def test_notify_not_an_int
    @writer.notify_not_an_int @stream
    @stream.rewind
    refute @stream.read.empty?
  end

  def test_ask_for_int_in_list
    @writer.ask_for_int_in_list [1, 2, 3], @stream
    @stream.rewind
    refute @stream.read.empty?
  end

  def test_ask_for_x_or_o
    @writer.ask_x_or_o @stream
    @stream.rewind
    refute @stream.read.empty?
  end

  def test_notify_not_x_or_o
    @writer.notify_not_x_or_o @stream
    @stream.rewind
    refute @stream.read.empty?
  end
end
