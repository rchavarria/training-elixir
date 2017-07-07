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

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      # set the game as won or lost
      game = Game.new_game() |> Map.put(:game_state, state)

      # use pattern matching in the assertion. ^ is used to keep the binding in the left
      # hand side of game, so that it must be the same as the game in the right hand side
      # for the pattern matching to work
      assert { ^game, _ } = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not alraedy used" do
    game = Game.new_game()
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is alraedy used" do
    game = Game.new_game()
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state != :already_used

    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

end
