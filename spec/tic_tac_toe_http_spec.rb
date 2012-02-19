require 'tic_tac_toe_http'
require 'test/unit'
require 'rack/test'

set :environment, :test

describe 'TicTacToeHttp' do
  include Rack::Test::Methods

  def app
    TicTacToeHttp
  end

  it "redirects root to choose_player on first access" do
    get '/'
    last_response.should be_redirect
    follow_redirect!
    last_request.url.should == 'http://example.org/choose_player'
  end

  it "redirects to root after x or o is chosen" do
    post '/choose_player', params={:player => 'o'}
    last_response.should be_redirect
    follow_redirect!
    last_request.url.should == 'http://example.org/'
  end
end
