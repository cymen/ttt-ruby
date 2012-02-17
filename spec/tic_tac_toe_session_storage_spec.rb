require 'tic_tac_toe_session_storage'
require 'board'

describe TicTacToeSessionStorage do
  before(:each) do
    class TicTacToeSessionStorageTester
      include TicTacToeSessionStorage
    end
    @http = TicTacToeSessionStorageTester.new
  end

  it "returns a new Board when attempting to retrieve board from storage" do
    storage = Hash.new
    board_from_storage = @http.get_board storage
    board_from_new = Board.new
    board_from_storage.count.should eq(board_from_new.count)
  end

  it "returns a Board as it was saved" do
    storage = Hash.new
    board = Board.new [:x,:x,:x]
    @http.save_board(board, storage)
    @http.get_board(storage).get_all_spaces.values.compact.should eq([:x,:x,:x])
  end

  it "returns a player as it was saved" do
    storage = Hash.new
    @http.save_player(:x, storage)
    @http.get_player(storage).should eq(:x)
  end

  it "saves a message to 'flash' on the next request and clears it after retrieval" do
    storage = Hash.new
    message = 'This is a test!'
    @http.flash(message, storage)
    @http.get_flash(storage).should eq(message)
    @http.get_flash(storage).should eq(nil)
  end
end
