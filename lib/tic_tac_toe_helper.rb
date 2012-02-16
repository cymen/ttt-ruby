module TicTacToeHelper
  def get_players
    [:x, :o]
  end

  def turn board
    first, second = get_players
    (board.count(first) == board.count(second)) ? first : second
  end

  def opposite_of player
    get_players.find do |symbol|
      player != symbol
    end
  end

end
