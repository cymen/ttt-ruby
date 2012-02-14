require 'prompter'
require 'test/unit'
require 'stringio'

class PrompterReadTest < Test::Unit::TestCase
  def read(input)
    input_stream = StringIO.new input
    Prompter::Reader.read_int(input_stream)
  end
  
  def test_with_an_int
    assert_equal 12, read('12')
  end

  def test_with_leading_char
    refute read('a12')
  end
  
  def test_with_trailing_char
    refute read('12a')
  end
  
  def test_with_char_in_middle
    refute read('1a2')
  end
end
