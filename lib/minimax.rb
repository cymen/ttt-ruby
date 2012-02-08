module Minimax

  Infinity = 1.0/0

  def Minimax.run board
    @initial_turn = Rules.turn board

    Minimax.minimax board
  end

  def Minimax.minimax board, depth = 1
    player = Rules.turn board
    max = -1 * Infinity

    choices = Hash.new
    board.empty.each do |space|
      choices[space] = 10
    end
    choices
  end
end
