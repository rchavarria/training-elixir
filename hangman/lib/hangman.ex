defmodule Hangman do

  alias Hangman.Game, as: Game

  defdelegate new_game(),             to: Game
  defdelegate new_game(word),         to: Game
  defdelegate tally(game),            to: Game
  defdelegate make_move(game, guess), to: Game

end
