class BoardPrinter
  ConsoleWidth = 80
  CellWidth = 5

  def self.print_banner writer=Writer
    writer.display_banner_text "Tic-Tac-Toe"
    writer.display_centered_text "The game is simple: attempt to beat your opponent by getting 3 in a row"
    writer.display_centered_text "(horizontal, vertical or diagonal)"
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
    end

    def self.board_row_header row_index
      header = lambda do |index|
        index.to_s.ljust(CellWidth)
      end

      board_row(header, row_index.first, row_index.last).center(ConsoleWidth)
    end

    def self.board_row_contents board, row_index
      content = lambda do |index|
        board.get(index).to_s.center(CellWidth)
      end

      board_row(content, row_index.first, row_index.last).center(ConsoleWidth)
    end

    def self.board_row_empty row_index
      board_row_repeated_char ' ', row_index.first, row_index.last
    end

    def self.board_row_seperator row_index
      board_row_repeated_char '_', row_index.first, row_index.last
    end

    def self.board_row_repeated_char char, first, last
      repeat = lambda do |index|
        char * CellWidth
      end

      board_row(repeat, first, last).center(ConsoleWidth)
    end

    def self.board_row callback, first, last
      line = ""
      (first..last).each do |index|
        line += callback.call(index).to_s
        line += '|' if index != last
      end
      line
    end
  end
end
