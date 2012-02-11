module Negamax

  Infinity = 1.0/0

  def Negamax.run board
    @initial_player = Game.turn board

    result = {}

    board.empty.each do |space|
      board.set space, Game.turn(board)
      result[space] = -negamax(board)
      board.clear space
    end

    return result
  end

  def Negamax.negamax board, depth = 1, alpha = -Infinity, beta = Infinity
    return alpha if depth > 8 
    return sign_toggle(board) * analysis(board, depth) if Game.over? board

    player = Game.turn board
    max = -Infinity

    board.empty.each do |space|
      board.set space, player
      max = [-negamax(board, depth + 1, -beta, -alpha), max].max
      board.clear space
      alpha = [alpha, max].max
      return alpha if alpha >= beta
    end

    return max
  end

  def Negamax.analysis board, depth
   if Game.winner? board
      return (2 ** -depth) * ((initial_player_is_winner board) ? 1 : -1)
    elsif Game.tie? board
      return 0
    end
  end  

  def Negamax.sign_toggle board
    (initial_player_is_winner board) ? -1 : 1
  end

  def Negamax.initial_player_is_winner board
    @initial_player == Game.winner(board)
  end

  def Negamax.opposite_player_of player
    (player == :x) ? :o : :x
  end

  def Negamax.sort_by_optimal_space_first choices
    best = [1, 3, 7, 9, 5]


  end
end
