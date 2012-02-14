require 'prompter'
require 'test/unit'

# tests
class PrompterTest < Test::Unit::TestCase
  def setup
    @reader = MockReader.new
    @writer = MockWriter.new
  end
  
  def test_integer_happy_path
    @reader.int_responses = [12]
    assert_equal 12, Prompter.integer(@reader, @writer)
    assert_equal 1, @reader.times_read_int
    assert_equal 1, @writer.times_asked_for_int
    assert_equal 0, @writer.times_notified_not_an_int
  end

  def test_integer_two_invalid_inputs
    @reader.int_responses = [nil, false, 1212]
    assert_equal 1212, Prompter.integer(@reader, @writer)
    assert_equal 3, @reader.times_read_int
    assert_equal 3, @writer.times_asked_for_int
    assert_equal 2, @writer.times_notified_not_an_int
  end

  def test_integer_in_list_happy_path
    @reader.int_responses = [3]
    assert_equal 3, Prompter.integer_in_list([1, 2, 3], @reader, @writer)
    assert_equal 1, @reader.times_read_int
    assert_equal 1, @writer.times_asked_for_int_in_list
    assert_equal 0, @writer.times_notified_not_an_int
    assert_equal 0, @writer.times_notified_not_in_list
  end

  def test_integer_in_list_one_invalid_input
    @reader.int_responses = ['a', 8]
    assert_equal 8, Prompter.integer_in_list([7, 8, 9], @reader, @writer)
    assert_equal 2, @reader.times_read_int
    assert_equal 2, @writer.times_asked_for_int_in_list
    assert_equal 0, @writer.times_notified_not_an_int
    assert_equal 1, @writer.times_notified_not_in_list
  end

  def test_string_x_or_o_happy_path
    @reader.string_responses = ["x"]
    assert_equal "x", Prompter.x_or_o(@reader, @writer)
    assert_equal 1, @reader.times_read_string
    assert_equal 1, @writer.times_asked_for_x_or_o
    assert_equal 0, @writer.times_notified_not_x_or_o
  end
  
  def test_string_x_or_o_one_invalid_input
    @reader.string_responses = ["z", "x"]
    assert_equal "x", Prompter.x_or_o(@reader, @writer)
    assert_equal 2, @reader.times_read_string
    assert_equal 2, @writer.times_asked_for_x_or_o
    assert_equal 1, @writer.times_notified_not_x_or_o
  end
end


# mocks
class PrompterTest
  class MockWriter
    attr_accessor :times_asked_for_int, :times_asked_for_int_in_list,
        :times_asked_for_x_or_o, :times_notified_not_an_int,
        :times_notified_not_in_list, :times_notified_not_x_or_o
    def initialize
      self.times_asked_for_int = 0
      self.times_asked_for_int_in_list = 0
      self.times_asked_for_x_or_o = 0
      self.times_notified_not_an_int = 0
      self.times_notified_not_in_list = 0
      self.times_notified_not_x_or_o = 0
    end
    
    def ask_for_int
      self.times_asked_for_int += 1
    end

    def ask_for_int_in_list list
      self.times_asked_for_int_in_list += 1
    end

    def ask_x_or_o
      self.times_asked_for_x_or_o += 1 
    end
    
    def notify_not_an_int
      self.times_notified_not_an_int += 1
    end

    def notify_not_in_list
      self.times_notified_not_in_list += 1
    end

    def notify_not_x_or_o
      self.times_notified_not_x_or_o += 1
    end
  end
  
  class MockReader
    attr_accessor :times_read_int, :times_read_string, :int_responses,
      :string_responses

    def initialize
      self.times_read_int = 0
      self.times_read_string = 0
    end
    
    def read_int
      self.times_read_int += 1
      int_responses.shift
    end

    def read_string
      self.times_read_string += 1
      string_responses.shift
    end
  end
end
