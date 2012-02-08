module Scorer
  def Scorer.tie? board
    board.empty.count == 0
  end

  def Scorer.winner board
    board.get_rows.each do |row|
      return row.first if Scorer.same_and_not_nil? row
    end
    nil
  end

  def Scorer.same_and_not_nil? row
    return (!row.first.nil? and row.uniq.length == 1)
  end
end
