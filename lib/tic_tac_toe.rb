module TicTacToe
  def self.play
    board = Board.new
    human = HumanPlayer.new ask_human_x_or_o
    computer = ComputerPlayer.new (human.is == :x) ? :o : :x
    while !Scorer.over? board
      (turn(board) == human.is) ? human.play(board) : computer.play(board)
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

  def self.ask_human_x_or_o
    choice = Prompter.x_or_o
    (choice == 'X') ? :x : :o
  end

  def self.turn board
    (board.count(:x) == board.count(:o)) ? :x : :o
  end
end
