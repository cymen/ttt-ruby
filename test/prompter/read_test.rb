require 'prompter'
require 'test/unit'
require 'stringio'

class PrompterReadTest < Test::Unit::TestCase
  def read_int(input)
    input_stream = StringIO.new input
    Prompter::Reader.read_int(input_stream)
  end
 
  def read_string(input)
    input_stream = StringIO.new input
    Prompter::Reader.read_string(input_stream)
  end

  def test_with_an_int
    assert_equal 12, read_int('12')
  end

  def test_with_leading_char
    refute read_int('a12')
  end
  
  def test_with_trailing_char
    refute read_int('12a')
  end
  
  def test_with_char_in_middle
    refute read_int('1a2')
  end

  def test_with_a_string
    assert_equal "abc", read_string("abc")
  end
end
