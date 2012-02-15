$: << 'lib'
require 'sinatra'
require 'json'
require 'tic_tac_toe_turn'
require 'board'
require 'html_printer'

use Rack::Session::Pool
include TicTacToeTurn

get '/' do
  @board = HtmlPrinter.print_board(Board.new)
  erb :index
end

get '/jjj' do
  content_type :json
  { 1 => :x, 2 => :o, 3 => :x }.to_json
end
