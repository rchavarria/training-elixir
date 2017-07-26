defmodule Hangman do

  def new_game() do
    Hangman.VisitorCounter.start_link()
    visits = Hangman.VisitorCounter.update_counts()

    IO.puts "Creating a new game, you're the #{visits}th visit"

    # instead of starting the game with `Server.new_game`, we need to use
    # the supervisor instead
    {:ok, game_pid } = Supervisor.start_child(Hangman.Supervisor, [])
    game_pid
  end

  def tally(game_pid) do
    GenServer.call(game_pid, { :tally })
  end

  def make_move(game_pid, guess) do
    GenServer.call(game_pid, { :make_move, guess })
  end

end
