module TicTacToeSessionStorage
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
