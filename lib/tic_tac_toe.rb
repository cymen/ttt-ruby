require 'board'
require 'console_printer'
require 'scorer'
require 'prompter'
require 'computer_player'
require 'human_player'
require 'tic_tac_toe_helper'

class TicTacToe
  include TicTacToeHelper

  def play
    print_start

    game

    while play_again?
      game
    end
  end

  # create mock players
  def game # player1, player2
    board = Board.new
    human = HumanPlayer.new ask_human_x_or_o
    computer = ComputerPlayer.new (human.is? :x) ? :o : :x

    while !Scorer.over? board
      (human.is? turn(board)) ? human.play(board) : computer.play(board)
    end

    print_end board
  end

  #class TicTacToeHelpers

  def print_start
    ConsolePrinter.print_centered "Tic-Tac-Toe"
  end

  def print_end board
    ConsolePrinter.print_board board

    if Scorer.winner? board
      ConsolePrinter.print_centered "#{Scorer.winner(board).upcase} won!"
    else
      ConsolePrinter.print_centered "Tie!"
    end
  end

  def ask_human_x_or_o
    (Prompter.x_or_o.casecmp('x') == 0) ? :x : :o
  end

  def play_again?
    Prompter.play_again.casecmp('Y') == 0
  end

 #end
end
