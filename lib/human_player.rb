class HumanPlayer
  def initialize i_am
    @i_am = i_am
  end

  def is
    @i_am
  end

  def play board
    ConsolePrinter.print_board board
    choice = Prompter.integer_in_list board.empty.sort
    board.set choice, @i_am
  end
end
