module Game
  def Game.turn board
    (board.count(:x) == board.count(:o)) ? :x : :o
  end

  def Game.over? board
    (Game.winner? board or Game.tie? board)
  end

  def Game.tie? board
    board.empty.count == 0
  end

  def Game.winner? board
    !Game.winner(board).nil?
  end

  def Game.winner board
    board.get_rows.each do |row|
      return row.first if Game.same_and_not_nil? row
    end
    nil
  end

  def Game.same_and_not_nil? row
    (!row.first.nil? and row.uniq.length == 1)
  end
end
