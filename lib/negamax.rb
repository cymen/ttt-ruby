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

    if Game.over? board
      return sign_toggle(board) * analysis(board, depth)
    end

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
      return 2 ** -depth
    elsif Game.tie? board
      return 0
    end
  end

  def Negamax.sign_toggle board
    (@initial_player == Game.winner(board)) ? -1 : 1
  end
end
