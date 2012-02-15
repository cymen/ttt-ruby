module ConsolePrinter
  ConsoleWidth = 80
  CellWidth = 5

  def self.print_centered text, writer=Writer
    writer.display_banner_text text
  end

  def self.print_board board, writer=Writer
    writer.display_board board
  end
  
  class Writer
    def self.display_blank_line output_stream=$stdout
      output_stream.puts
    end

    def self.display_banner_text text, output_stream=$stdout
      display_blank_line output_stream
      display_centered_text text, output_stream
      display_blank_line output_stream
    end

    def self.display_centered_text text, output_stream=$stdout
      output_stream.puts text.center(ConsoleWidth)
    end

    def self.display_board board, output_stream=$stdout
      display_blank_line output_stream
      row_indexes = board.get_horizontal_row_index_sets
      row_indexes.each do |row_index|
        output_stream.puts board_row_header row_index
        output_stream.puts board_row_contents board, row_index
        if row_index != row_indexes.last
          output_stream.puts board_row_seperator row_index
        else
          output_stream.puts board_row_empty row_index
        end
      end
      display_blank_line output_stream
    end

    def self.board_row_header row_index
      header = lambda do |index|
        index.to_s.ljust(CellWidth)
      end

      board_row(header, row_index).center(ConsoleWidth)
    end

    def self.board_row_contents board, row_index
      content = lambda do |index|
        board.get(index).to_s.upcase.center(CellWidth)
      end

      board_row(content, row_index).center(ConsoleWidth)
    end

    def self.board_row_empty row_index
      board_row_repeated_char ' ', row_index
    end

    def self.board_row_seperator row_index
      board_row_repeated_char '_', row_index
    end

    def self.board_row_repeated_char char, row_index
      repeat = lambda do |index|
        char * CellWidth
      end

      board_row(repeat, row_index).center(ConsoleWidth)
    end

    def self.board_row callback, row_index
      line = ""
      (row_index.first..row_index.last).each do |index|
        line += callback.call(index).to_s
        line += '|' if index != row_index.last
      end
      line
    end
  end
end
