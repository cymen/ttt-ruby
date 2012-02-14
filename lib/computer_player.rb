class ComputerPlayer
  def initialize i_am
    @i_am = i_am
  end

  def is
    @i_am
  end

  def play board
    choice = random_best_from(Negamax.run board)
    board.set choice, @i_am
  end

  def optimal_choices_on_empty_board
    return [1, 3, 5, 7, 9]
  end

  def filter_weighted_choices_to_best choices
    choices.reject { |space, weight| weight != choices.values.max }.keys
  end 

  def random_choice_from choices
    choices[rand(choices.count)]
  end

  def random_best_from choices
    random_choice_from filter_weighted_choices_to_best(choices)
  end
end
