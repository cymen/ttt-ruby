module Game
  def self.play
    board = Board.new
    while !over? board
      if turn(board) == :x
        all_choices = Negamax.run board
        best_choices = all_choices.reject { |key, value| value != all_choices.values.max }.keys
        random_choice_of_best = best_choices[rand(best_choices.count)]
        board.set random_choice_of_best, :x
      else
        # prompt for input
        puts
        puts board
        puts
        have_choice = false
        while !have_choice
          puts "Pick a space from #{board.empty.sort}: "
          choice = STDIN.gets.to_i
          have_choice = true if board.empty.count(choice) == 1
        end
        board.set choice, :o
      end
    end

    puts
    puts board
    puts
    if self.winner? board
      puts "Winner: #{winner board}"
    else
      puts "Tie!"
    end
  end

  def self.turn board
    (board.count(:x) == board.count(:o)) ? :x : :o
  end

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

  def self.same_or_nil? row
    row.select { |value| !value.nil? }.uniq.count <= 1
  end
end
