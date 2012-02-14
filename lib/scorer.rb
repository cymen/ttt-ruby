module Scorer
  def self.over? board
    (winner? board or tie? board)
  end

  def self.tie? board
    board.empty.count == 0
  end

  def self.winner? board
    !winner(board).nil?
  end

  def self.winner board
    board.get_rows.each do |row|
      return row.first if same_and_not_nil? row
    end
    nil
  end

  def self.same_and_not_nil? row
    (!row.first.nil? and row.uniq.length == 1)
  end
end
