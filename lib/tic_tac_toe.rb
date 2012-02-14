module TicTacToe
  def self.play
    board = Board.new
    human = ask_x_or_o
    puts "human is: #{human}"
    exit
    while !Scorer.over? board
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
    if Scorer.winner? board
      puts "Winner: #{Scorer.winner board}"
    else
      puts "Tie!"
    end
  end

  def self.ask_x_or_o
    Prompter.x_or_o
  end

  def self.turn board
    (board.count(:x) == board.count(:o)) ? :x : :o
  end
end
