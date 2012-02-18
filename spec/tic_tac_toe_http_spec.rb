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
end
