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
    @board_html = HtmlPrinter.print_board(board, '/play')
    erb :index
  end

  get '/choose_player' do
    erb :choose_player
  end

  get '/choose_player/:player' do
    player = params[:player]

    save_player :x if player.casecmp('x', player) == 0
    save_player :o if player.casecmp('o', player) == 0

    redirect to('/')
  end

  get '/play/:space' do
    board = get_board
    space = params[:space].to_i

    error "Invalid move: nonexistent space!" if space > 9 or space < 1
    error "Invalid move: space already played!" if !board.get(space).nil?

    board.set(space, :x)
    ComputerPlayer.new(:o).play(board)
    save_board board

    redirect to('/')
  end

  get '/reset' do
    reset

    redirect to('/')
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
