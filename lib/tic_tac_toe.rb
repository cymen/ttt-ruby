module TicTacToe
  def self.play
    print_start

    board = Board.new
    human = HumanPlayer.new ask_human_x_or_o
    computer = ComputerPlayer.new (human.is == :x) ? :o : :x

    while !Scorer.over? board
      (turn(board) == human.is) ? human.play(board) : computer.play(board)
    end

    Scorer.print_end board

    # TODO:  prompt to play again
 end

  def self.print_start
    ConsolePrinter.print_centered "Tic-Tac-Toe"
  end

  def self.ask_human_x_or_o
    (Prompter.x_or_o.casecmp('x') == 0) ? :x : :o
  end

  def self.turn board
    (board.count(:x) == board.count(:o)) ? :x : :o
  end
end
