module Minimax

  Infinity = 1.0/0

  def Minimax.run board
    @initial_turn = Game.turn board

    result = {}

    board.empty.each do |space|
      @special = space == 1
      board.set space, Game.turn(board)
      result[space] = Minimax.minimax board
      if @special
        puts "board: " + board.to_s + ", initial pick: " + space.to_s
        puts "result: " + result.to_s
      end
      board.clear space
    end

    return result
  end

  def Minimax.minimax board, depth = 1

    if Game.over? board
      return Minimax.sign_toggle(board) * Minimax.analysis(board, depth)
    end

    player = Game.turn board
    max = -1 * Infinity

    z = {}
    board.empty.each do |space|
      board.set space, player
      value = -Minimax.minimax(board, depth + 1)
      max = [value, max].max
      z[space] = value 
      board.clear space
    end

    if @special and depth == 1
      puts "z: " + z.to_s
    end

    return max
  end

  def Minimax.analysis board, depth
   if Game.winner? board
      # the returned value seems backward --
      return (2 ** -depth) * ((@initial_turn == Game.winner(board)) ? 1 : -1)
      #return (@initial_turn == Game.winner(board)) ? board.empty.count : -board.empty.count
      #return ((@initial_turn == Game.winner(board)) ? -1 : 1) * 2 ** -depth
    elsif Game.tie? board
      return 0
    end
   
  end

  def Minimax.sign_toggle board
    (@initial_turn == Game.winner(board)) ? 1 : -1
  end
end
