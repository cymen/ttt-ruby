class Board
  :spaces

  HORIZONTAL_ROWS = [[1,2,3], [4,5,6], [7,8,9]]
  VERTICAL_ROWS =   [[1,4,7], [2,5,8], [3,6,9]]
  DIAGONAL_ROWS =   [[1,5,9], [3,5,7]]

  def initialize values = []
    @spaces =  {}
    (1..9).each do |space|
      @spaces[space] = values[space-1]
    end
  end

#  def space value = nil
#    @spaces[space] = value if not value.nil?
#    @spaces[space]
#  end

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
    (HORIZONTAL_ROWS + VERTICAL_ROWS + DIAGONAL_ROWS).each do |spaces|
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
