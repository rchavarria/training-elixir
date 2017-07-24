defmodule Hangman do

  alias Hangman.Server

  def new_game() do
    Server.start_link()
  end

  def tally(game_pid) do
    GenServer.call(game_pid, { :tally })
  end

  def make_move(game_pid, guess) do
    GenServer.call(game_pid, { :make_move, guess })
  end

end
