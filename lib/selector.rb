class Selector
  def horizontal
    return [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def vertical
    return [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  end

  def diagonal
    return [[1, 5, 9], [3, 5, 7]]
  end

  def all
    return horizontal + vertical + diagonal
  end
end
