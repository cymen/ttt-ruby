$: << 'lib'
require 'sinatra'
require 'json'
require 'tic_tac_toe_helper'
require 'computer_player'
require 'board'
require 'html_printer'
require 'scorer'

class TicTacToe < Sinatra::Base
  use Rack::Session::Pool
  include TicTacToeHelper

  get '/' do
    @flash = get_flash

    redirect to('/choose_player') if get_player.nil?

    board = get_board
    computer_play board

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

    redirect to('/')
  end

  get '/reset' do
    reset

    redirect to('/')
  end

  def computer_play board
    ComputerPlayer.new(opposite_of get_player).play(board) if turn(board)== opposite_of(get_player)
    save_board board
  end

  def get_board
    (!session[:board].nil?) ? Marshal.load(session[:board]) : Board.new
  end

  def get_player
    (!session[:player].nil?) ? Marshal.load(session[:player]) : nil
  end

  def save_board board
    session[:board] = Marshal.dump(board)
  end

  def save_player player
    session[:player] = Marshal.dump(player)
  end

  def reset
    session.delete(:board)
    session.delete(:player)
  end

  def flash message
    session[:notice] = message
  end

  def error message
    flash message
    redirect to('/')
  end

  def get_flash
    session.delete(:notice)
  end
end

TicTacToe.run! if __FILE__ == $0
