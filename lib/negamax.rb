module Negamax

  Infinity = 1.0/0
  Optimal = [1, 3, 5, 7, 9]

  def self.run board
    @initial_player = TicTacToe.turn board
    @spaces_count = board.count

    weighted_choices = {}

    sort_choices_optimally(board.empty).each do |space|
      board.set space, TicTacToe.turn(board)
      weighted_choices[space] = -negamax(board)
      board.clear space
    end

    weighted_choices
  end

  def self.negamax board, depth = 1, alpha = -Infinity, beta = Infinity
    return alpha if depth > (@spaces_count - 1) 
    return sign_toggle(board) * analysis(board, depth) if Scorer.over? board

    player = TicTacToe.turn board
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

  def self.analysis board, depth
   if Scorer.winner? board
      return (2 ** -depth) * ((initial_player_is_winner board) ? 1 : -1)
    elsif Scorer.tie? board
      return 0
    end
  end  

  def self.sign_toggle board
    (initial_player_is_winner board) ? -1 : 1
  end


  # TODO:  figure out how to test -- problem: how to set @initial_player value in test?
  def self.initial_player_is_winner board
    @initial_player == Scorer.winner(board)
  end

  def self.sort_choices_optimally choices
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
