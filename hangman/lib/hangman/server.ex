defmodule Hangman.Server do

  alias Hangman.Game

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_arguments) do
    game = Game.new_game()

    # init must return a tuple, :ok and GenServer's state
    { :ok, game }
  end

  # state is the `game` that saves the GenServer
  def handle_call({ :make_move, guess }, _from, game) do
    { game, tally } = Game.make_move(game, guess)

    # return a reply, the tally will be returned to the caller and
    #game will be the new GenServer state
    { :reply, tally, game }
  end

  # state is the `game` that saves the GenServer
  def handle_call({ :tally }, _from, game) do
    { :reply, Game.tally(game), game }
  end

end
