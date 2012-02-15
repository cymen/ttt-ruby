class Board

  SideLength = 3
  Horizontal_Rows = [[1,2,3], [4,5,6], [7,8,9]]
  Vertical_Rows   = [[1,4,7], [2,5,8], [3,6,9]]
  Diagonal_Rows   = [[1,5,9], [3,5,7]]

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

  def clear space
    set space, nil
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

  def get_horizontal_row_index_sets
    return Horizontal_Rows
  end

  def count value = nil
    (value.nil?) ? @spaces.values.count : @spaces.values.count(value)
  end

  def empty
    (@spaces.select { |_, value| value.nil? }).keys
  end

  def empty?
    empty.count == (SideLength ** 2)
  end

  def side_length
    SideLength
  end
end
