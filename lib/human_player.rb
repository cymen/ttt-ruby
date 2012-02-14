class HumanPlayer
  def initialize i_am
    @i_am = i_am
  end

  def is
    @i_am
  end

  def play board
    ConsolePrinter.print_board board
    choice = get_choice board
    board.set choice, @i_am
  end

  def get_choice board
    Prompter.integer_in_list board.empty.sort
  end
end
