$: << 'lib'
require 'sinatra'
require 'json'
require 'tic_tac_toe_turn'
require 'computer_player'
require 'board'
require 'html_printer'

class TicTacToe < Sinatra::Base
  use Rack::Session::Pool
  include TicTacToeTurn

  get '/' do
    @flash = get_flash
    board = get_board
    @board_html = HtmlPrinter.print_board(board, '/play')
    erb :index
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

  def get_board
    (!session[:board].nil?) ? Marshal.load(session[:board]) : Board.new
  end

  def save_board board
    session[:board] = Marshal.dump(board)
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
