class Prompter
  def self.integer reader=Reader, writer=Writer
    writer.ask_for_int
    int = reader.read_int
    return int if int
    writer.notify_not_an_int
    self.integer reader, writer
  end

  def self.integer_in_list list, reader=Reader, writer=Writer
    writer.ask_for_int_in_list list
    int = reader.read_int
    return int if int and list.count(int) > 0
    writer.notify_not_in_list
    self.integer_in_list list, reader, writer
  end

  def self.x_or_o reader=Reader, writer=Writer
    writer.ask_x_or_o
    choice = reader.read_string.upcase
    return choice if ['X', 'O'].count(choice) > 0
    writer.notify_not_x_or_o
    self.x_or_o reader, writer
  end

  def self.play_again reader=Reader, writer=Writer
    writer.ask_play_again
    choice = reader.read_string.upcase
    return choice if ['Y', 'N'].count(choice) > 0
    writer.notify_not_y_or_n
    self.play_again reader, writer
  end

  class Writer
    def self.ask_for_int output_stream=$stdout
      output_stream.print 'Enter an integer: ' 
    end

    def self.ask_for_int_in_list list, output_stream=$stdout
      output_stream.print "Choose a space from #{list.sort}: "
    end

    def self.ask_play_again output_stream=$stdout
      output_stream.print "Play again (y/n)? "
    end

    def self.ask_x_or_o output_stream=$stdout
      output_stream.print "Would you like to be x or o (x always goes first)? " 
    end

    def self.notify_not_an_int output_stream=$stdout
      output_stream.puts 'That is not an integer'
    end

    def self.notify_not_in_list output_stream=$stdout
      output_stream.puts 'That choice is not in the list'
    end

    def self.notify_not_y_or_n output_stream=$stdout
      output_stream.puts 'That choice is not valid. Please choose y or n!'
    end

    def self.notify_not_x_or_o output_stream=$stdout
      output_stream.puts 'That choice is not valid. Please choose x or o!'
    end
  end

  class Reader
    def self.read_int input_stream=$stdin
      input = input_stream.gets
      input[/^\d+$/] && input.to_i
    end
    def self.read_string input_stream=$stdin
      input_stream.gets.chomp
    end
  end
end
