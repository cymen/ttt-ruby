class Scorer
  def game_over? board
    selector = Selector.new
    over, winner = winning_row?(board, selector.all)
    return true, winner if over

    return true, :tie if tie?(board)

    false
  end

  def tie? board
    return true if !board.spaces.has_value? nil
  end

  def winning_row? board, row_index_sets
    row_index_sets.each do |row_index_set|
      row = board.get(row_index_set)
      return true, row.first if won?(row)
    end
    false
  end

  def won? row
    return (row.uniq.length == 1 and !row.first.nil?)
  end
end
