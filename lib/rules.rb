module Rules
  def Rules.turn board
    (board.count(:x) == board.count(:o)) ? :x : :o
  end
end
