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

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    { game, _ } = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "only lowercase guesses are allowed" do
    game = Game.new_game()
    { game, _ } = Game.make_move(game, "X")
    assert game.game_state == :only_lowercase_allowed
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    { game, _ } = Game.make_move(game, "x")
    assert game.game_state != :already_used

    { game, _ } = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    { game, _ } = Game.make_move(game, "w")
    assert game.game_state == :good_guess  # I did a good guess
    assert game.turns_left == 7       # I didn't lose a turn
  end

  test "a guessed word is a won game" do
    game = Game.new_game("wibble")
    { game, _ } = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    { game, _ } = Game.make_move(game, "i")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    { game, _ } = Game.make_move(game, "b")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    { game, _ } = Game.make_move(game, "l")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    { game, _ } = Game.make_move(game, "e")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "(Enum.reduce) a guessed word is a won game" do
    moves = [
      { "w", :good_guess },
      { "i", :good_guess },
      { "b", :good_guess },
      { "l", :good_guess },
      { "e", :won }
    ]

    game = Game.new_game("wibble")

    Enum.reduce(moves, game, fn ({ guess, state }, game) -> 
      { game, _ } = Game.make_move(game, guess)
      assert game.game_state == state
      assert game.turns_left == 7

      game
    end)
  end

  test "bad guess is recognized" do
    game = Game.new_game("wibble")
    { game, _ } = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "seven bad guesses and you're lost" do
    moves = [
      { "a", :bad_guess, 6 },
      { "b", :bad_guess, 5 },
      { "c", :bad_guess, 4 },
      { "d", :bad_guess, 3 },
      { "e", :bad_guess, 2 },
      { "f", :bad_guess, 1 },
      { "g", :lost, 0 },
    ]

    game = Game.new_game("w")

    Enum.reduce(moves, game, fn ({ guess, state, turns_left }, game) -> 
      { game, _ } = Game.make_move(game, guess)
      assert game.game_state == state
      assert game.turns_left == turns_left

      game
    end)
  end

end
