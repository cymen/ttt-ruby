require 'board.rb'
require 'console_printer.rb'
require 'scorer.rb'
require 'prompter.rb'
require 'computer_player.rb'
require 'human_player.rb'

module TicTacToe
  def self.play
    print_start

    game

    while play_again
      game
    end

  end

  # create mock players
  def self.game # player1, player2
    board = Board.new
    human = HumanPlayer.new ask_human_x_or_o
    computer = ComputerPlayer.new (human.is == :x) ? :o : :x

    while !Scorer.over? board
      #(human.is?(turn board)) ? 
      (turn(board) == human.is) ? human.play(board) : computer.play(board)
    end

    print_end board
  end

  #class TicTacToeHelpers

  def self.print_start
    ConsolePrinter.print_centered "Tic-Tac-Toe"
  end

  def self.print_end board
    ConsolePrinter.print_board board

    if Scorer.winner? board
      ConsolePrinter.print_centered "#{Scorer.winner(board).upcase} won!"
    else
      ConsolePrinter.print_centered "Tie!"
    end
  end

  def self.ask_human_x_or_o
    (Prompter.x_or_o.casecmp('x') == 0) ? :x : :o
  end

  def self.play_again
    Prompter.play_again == 'Y'
  end

  def self.turn board
    (board.count(:x) == board.count(:o)) ? :x : :o
  end
  #end
end
