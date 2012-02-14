module Negamax

  Infinity = 1.0/0
  Optimal = [1, 3, 5, 7, 9]

  def self.run board
    @initial_player = TicTacToe.turn board
    @spaces_count = board.count

    result = {}

    sort_choices_optimally(board.empty).each do |space|
      board.set space, TicTacToe.turn(board)
      result[space] = -negamax(board)
      board.clear space
    end

    return result
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

    return max
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

  def self.initial_player_is_winner board
    @initial_player == Scorer.winner(board)
  end

  def self.sort_choices_optimally choices
    result = []
    choices.each do |choice|
      if Optimal.count(choice) > 0
        result.unshift choice
      else
        result.push choice
      end
    end
    result
  end
end
