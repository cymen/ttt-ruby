module Minimax

  Infinity = 1.0/0

  def Minimax.run board
    @initial_turn = Rules.turn board

    result = Minimax.minimax board
    return result
  end

  def Minimax.minimax board, depth = 1
    
    if Scorer.over? board
      return Minimax.something(board) * Minimax.analysis(board)
    end
    
    player = Rules.turn board
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
    if Scorer.tie? board
      return 0
    elsif Scorer.winner? board
      # the returned value seems backward -- 
      #return (@initial_turn == Scorer.winner(board)) ? -1 : 1
      return (@initial_turn == Scorer.winner(board)) ? board.empty.count : -board.empty.count
    end
  end

  def Minimax.something board
    (@initial_turn == Scorer.winner(board)) ? -1 : 1
  end
end
