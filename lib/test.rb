load 'board_printer.rb'
load 'board.rb'

BoardPrinter.print_banner
BoardPrinter.print_board Board.new [:x, :o, :x, :o, :x, :o, :o, :x, :o]
