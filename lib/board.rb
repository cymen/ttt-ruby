class Board
  attr_reader :spaces

  def initialize values = []
    @spaces =  {}
    (1..9).each do |space|
      @spaces[space] = values[space-1]
    end
  end

  def get indexes
    result = []
    indexes.each do |index_or_indexes|
      if index_or_indexes.kind_of? Array
        result.push get index_or_indexes
      else
        result.push @spaces[index_or_indexes]
      end
    end
    result
  end

  def deep_clone
    return Marshal.load(Marshal.dump(self))
  end

  def empty
    return (@spaces.select { |index, value| value.nil? }).keys
  end
end
