require 'tic_tac_toe_helper'
require 'board'

class Negamax
  include TicTacToeHelper

  # TODO:  turn into class so can inject value into intial_player

  # put TicTacToe.turn into module which can include where used (mixin)

  attr_accessor :initial_player
  attr_reader :spaces_count

  Infinity = 1.0/0
  Optimal = [1, 3, 5, 7, 9]

  def run board
    # TODO:  put TicTacToe.turn into utility class or into Board perhaps
    @initial_player = turn board
    @spaces_count = board.count

    weighted_choices = {}

    sort_choices_optimally(board.empty).each do |space|
      board.set space, turn(board)
      weighted_choices[space] = -negamax(board)
      board.clear space
    end

    weighted_choices
  end

  def negamax board, depth = 1, alpha = -Infinity, beta = Infinity
    return alpha if depth > (@spaces_count - 1) 
    return sign_toggle(board) * analysis(board, depth) if board.over?

    player = turn board
    max = -Infinity

    sort_choices_optimally(board.empty).each do |space|
      board.set space, player
      max = [-negamax(board, depth + 1, -beta, -alpha), max].max
      board.clear space
      alpha = [alpha, max].max
      return alpha if alpha >= beta
    end

    max
  end

  def analysis board, depth
   if board.winner?
      return (2 ** -depth) * ((initial_player_is_winner? board) ? 1 : -1)
    elsif board.tie?
      return 0
    end
  end  

  def sign_toggle board
    (initial_player_is_winner? board) ? -1 : 1
  end


  # TODO:  figure out how to test -- problem: how to set @initial_player value in test?
  def initial_player_is_winner? board
    @initial_player == board.winner
  end

  def sort_choices_optimally choices
    optimized_choices = []
    choices.each do |choice|
      if Optimal.count(choice) > 0
        optimized_choices.unshift choice
      else
        optimized_choices.push choice
      end
    end
    optimized_choices
  end
end
