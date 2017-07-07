defmodule Hangman.Game do

  # Gets the same name as the module, Hangman.Game
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters:    [],
    used:       MapSet.new()
  )

  def new_game() do
    %Hangman.Game{
      letters: Dictionary.random_word |> String.codepoints
    }
  end

  def make_move(game = %{ game_state: state }, _guess) when state in [:won, :lost] do
    { game, tally(game) }
  end

  def make_move(game, guess) do
    # as we can't do pattern maching or use guard clauses with MapSet.member?,
    # we need to delegate to a new function
    game = accept_move(game, guess, MapSet.member?(game.used, guess))
    { game, tally(game) }
  end

  def accept_move(game, _guess, _already_used = true) do
    Map.put(game, :game_state, :already_used)
  end

  def accept_move(game, guess, _already_used) do
    # update game state with a new MapSet into game.used
    # the new MapSet is a new set with the new guess saved on it
    Map.put(game, :used, MapSet.put(game.used, guess))
  end

  def tally(_game) do
    1234
  end

end
