module Minimax

  Infinity = 1.0/0

  def Minimax.run board
    @initial_turn = Game.turn board

    result = Minimax.minimax board
    return result
  end

  def Minimax.minimax board, depth = 1
    
    if Game.over? board
      return Minimax.sign_toggle(board) * Minimax.analysis(board)
    end
    
    player = Game.turn board
    max = -1 * Infinity

    choices = Hash.new
    board.empty.each do |space|
      board.set space, player

      choices[space] = -Minimax.minimax(board, depth + 1)

      board.clear space
    end
    
    return (depth == 1) ? choices : choices.values.max
  end

  def Minimax.analysis board
    if Game.tie? board
      return 0
    elsif Game.winner? board
      # the returned value seems backward -- 
      #return (@initial_turn == Game.winner(board)) ? -1 : 1
      return (@initial_turn == Game.winner(board)) ? board.empty.count : -board.empty.count
    end
  end

  def Minimax.sign_toggle board
    (@initial_turn == Game.winner(board)) ? -1 : 1
  end
end
