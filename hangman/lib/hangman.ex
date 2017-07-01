defmodule Hangman do

  alias Hangman.Game, as: Game

  defdelegate new_game(), to: Game

end
