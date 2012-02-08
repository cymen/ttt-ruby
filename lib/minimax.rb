class Minimax

  def initialize player
    @player = player
    @scorer = Scorer.new
  end

  def run board
    choices = Hash.new
    board.empty.each do |empty|
      choices[empty] = minimax @player, board.deep_clone, empty
    end
    choices
  end

  def minimax player, board, space, depth = 9 
    board.spaces[space] = player

    over, winner = @scorer.game_over? board
    if over
      return 0 if winner == :tie
      return (depth * ((winner == @player) ? 1 : -1))
    end

    score = 0 

    board.empty.each do |space|
      temp = minimax swap_player(player), board.deep_clone, space, depth -= 1
      #puts "score == " + score.to_s + ", temp == " + temp.to_s
      #score = temp if temp > score
      score = temp.abs if temp.abs > score
    end

    score
  end

  def swap_player player
    (player == :x) ? :o : :x
  end


  def weight depth
    return 100000 / (depth + 1)
  end

end
