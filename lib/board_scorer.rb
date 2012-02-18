module BoardScorer
  def over?
    (winner? or tie?)
  end

  def tie?
    empty.count == 0
  end

  def winner?
    !winner.nil?
  end

  def winner
    get_rows.each do |row|
      return row.first if same_and_not_nil? row
    end
    nil
  end

  def same_and_not_nil? row
    (!row.first.nil? and row.uniq.length == 1)
  end
end
