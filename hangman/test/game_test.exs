defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structrue" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "letters must be lowercase" do
    game = Game.new_game()

    lower_case = game.letters |> Enum.map(&String.downcase/1)

    assert game.letters == lower_case
  end

end
