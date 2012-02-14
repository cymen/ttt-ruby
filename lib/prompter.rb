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
    writer.notify_not_in_list list
    self.integer_in_list list, reader, writer
  end

  class Writer
    def self.ask_for_int output_stream=$stdout
      output_stream.print 'Enter an integer: ' 
    end

    def self.ask_for_int_in_list list, output_stream=$stdout
      output_stream.print "Choose an integer from #{list.sort}: "
    end

    def self.notify_not_an_int output_stream=$stdout
      output_stream.puts 'That is not an integer'
    end

    def self.notify_not_in_list output_stream=$stdout
      output_stream.puts 'That choice is not in the list'
    end
  end

  class Reader
    def self.read_int input_stream=$stdin
      input = input_stream.gets
      input[/^\d+$/] && input.to_i
    end
  end
end
