module TicTacToeHelper
  def get_players
    [:x, :o]
  end

  def get_player_labels
    ['X', 'O']
  end

  def turn board
    first, second = get_players
    (board.count(first) == board.count(second)) ? first : second
  end
end
