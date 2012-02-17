$: << 'lib'
require 'sinatra'
require 'tic_tac_toe_helper'
require 'computer_player'
require 'board'
require 'scorer'

class TicTacToeHttp < Sinatra::Base
  use Rack::Session::Pool
  include TicTacToeHelper

  get '/' do
    @flash = get_flash

    redirect to('/choose_player') if get_player.nil?

    board = get_board
    computer_play board
    redirect to('/over') if Scorer.over? board

    @spaces = board.get_all_spaces
    erb :index
  end

  get '/choose_player' do
    erb :choose_player
  end

  get '/choose_player/:player' do
    player = params[:player]

    (player.casecmp('x') == 0) ? save_player(:x) : save_player(:o)

    redirect to('/')
  end

  post '/play' do
    board = get_board
    space = params[:space].to_i

    error "Invalid play attempt: nonexistent space!" if space > 9 or space < 1
    error "Invalid play attempt: space already played!" if !board.get(space).nil?
    error "Invalid play attempt: it's not your turn!" if turn(board) != get_player

    board.set space, get_player
    save_board board

    redirect to('/over') if Scorer.over? board
    redirect to('/')
  end

  get '/over' do
    board  = get_board
    redirect to('/') if !Scorer.over? board

    @spaces = board.get_all_spaces
    @winning_indexes = board.get_winning_row_index_set
    @over = (Scorer.winner? board) ? "#{Scorer.winner(board).upcase} won!" : "Tie!"
    erb :over
  end

  get '/reset' do
    reset

    redirect to('/')
  end

  def computer_play board
    if turn(board) == opposite_of(get_player)
      ComputerPlayer.new(opposite_of get_player).play(board)
      save_board board
    end
  end

  def get_board storage=session
    (!storage[:board].nil?) ? Marshal.load(storage[:board]) : Board.new
  end

  def get_player storage=session
    (!storage[:player].nil?) ? Marshal.load(storage[:player]) : nil
  end

  def save_board board, storage=session
    storage[:board] = Marshal.dump(board)
  end

  def save_player player, storage=session
    storage[:player] = Marshal.dump(player)
  end

  def reset storage=session
    storage.delete(:board)
    storage.delete(:player)
  end

  def flash message, storage=session
    storage[:notice] = message
  end

  def error message
    flash message
    redirect to('/')
  end

  def get_flash storage=session
    storage.delete(:notice)
  end
end
