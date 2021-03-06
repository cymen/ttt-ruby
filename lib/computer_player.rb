require 'negamax'

class ComputerPlayer
  def initialize i_am
    @i_am = i_am
  end

  def is? symbol
    @i_am == symbol
  end

  def play board
    if board.empty?
      choice = random_choice_from(optimal_choices_on_empty_board)
    else
      choice = random_best_from(Negamax.new.run board)
    end
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
