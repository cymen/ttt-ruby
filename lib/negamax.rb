module Negamax

  Infinity = 1.0/0

  def Negamax.run board
    @initial_player = Game.turn board

    result = {}

    board.empty.each do |space|
      board.set space, Game.turn(board)
      result[space] = -Negamax.negamax(board)
      board.clear space
    end

    return result
  end

  def Negamax.negamax board, depth = 1

    if Game.over? board
      return Negamax.sign_toggle(board) * Negamax.analysis(board, depth)
    end

    player = Game.turn board
    max = -Infinity

    z = {}
    board.empty.each do |space|
      board.set space, player
      value = -Negamax.negamax(board, depth + 1)
      max = [value, max].max
      board.clear space
      z[space] = max
    end

    return max
  end

  def Negamax.analysis board, depth
   if Game.winner? board
      #return (@initial_player == Game.winner(board)) ? 1 : -1
      return (2 ** -depth) * ((@initial_player == Game.winner(board)) ? 1.01 : -1)
      #return (@initial_player == Game.winner(board)) ? board.empty.count : -board.empty.count
      #return (@initial_player == Game.winner(board)) ? -board.empty.count : board.empty.count
      #return ((@initial_player == Game.winner(board)) ? -1 : 1) * 2 ** -depth
    elsif Game.tie? board
      return 0
    end
   
  end

  def Negamax.sign_toggle board
    (@initial_player == Game.winner(board)) ? -1 : 1
  end
end
