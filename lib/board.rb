class Board
  Horizontal_Rows = [[1,2,3], [4,5,6], [7,8,9]]
  Vertical_Rows =   [[1,4,7], [2,5,8], [3,6,9]]
  Diagonal_Rows =   [[1,5,9], [3,5,7]]

  def initialize values = []
    @spaces =  {}
    (1..9).each do |space|
      @spaces[space] = values[space-1]
    end
  end

  def set space, value
    @spaces[space] = value
  end

  def get space
    @spaces[space]
  end

  def get_row spaces
    row = []
    spaces.each do |space|
      row.push get space
    end
    row
  end

  def get_rows
    rows = []
    (Horizontal_Rows + Vertical_Rows + Diagonal_Rows).each do |spaces|
      rows.push get_row spaces
    end
    rows
  end

  def count value
    @spaces.values.count(value)
  end

  def empty
    (@spaces.select { |index, value| value.nil? }).keys
  end
end
