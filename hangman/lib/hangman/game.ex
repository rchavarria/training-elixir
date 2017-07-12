defmodule Hangman.Game do

  # Gets the same name as the module, Hangman.Game
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters:    [],
    used:       MapSet.new(),
    used_list:  []
  )

  def new_game() do
    new_game(Dictionary.random_word)
  end

  def new_game(word) do
    %Hangman.Game{
      letters: word |> String.codepoints
    }
  end

  def make_move(game = %{ game_state: state }, _guess) when state in [:won, :lost] do
    { game, tally(game) }
  end

  def make_move(game, guess) do
    # as we can't do pattern maching or use guard clauses with MapSet.member?,
    # we need to delegate to a new function

    has_been_used = MapSet.member?(game.used, guess);
    # has_been_used = Enum.any?(game.used_list, fn x -> x == guess end)

    game = accept_move(game, guess, has_been_used)
    { game, tally(game) }
  end

  def accept_move(game, _guess, _already_used = true) do
    Map.put(game, :game_state, :already_used)
  end

  def accept_move(game, guess, _already_used) do
    # update game state with a new MapSet into game.used
    # the new MapSet is a new set with the new guess saved on it

    # Map.put(game, :used_list, [ guess | game.used_list ])
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  def score_guess(game, _good_guess = true) do
    new_state = MapSet.new(game.letters)      # create a MapSet from letters
                |> MapSet.subset?(game.used)  # used letters are a subset of the word's letters?
                |> maybe_won()                # user probably won the game, if not, he'll get a good guess

    Map.put(game, :game_state, new_state)
  end

  # you lose because it was a bad guess and there was only 1 turn left
  def score_guess(game = %{ turns_left: 1 }, _not_good_guess) do
    # Map.put(game, :game_state, :lost)
    # |> Map.put(game, :turns_left, 0)
    %{ game |
       game_state: :lost,
       turns_left: 0
     }
  end

  def score_guess(game = %{ turns_left: turns_left }, _not_good_guess) do
    # Map.put(game, :turns_left, turns_left - 1)
    # |> Map.put(game, :game_state, :bad_guess)
    # Or putting it prettier   %{ <map> | <key> <value> }
    %{ game | game_state: :bad_guess,
              turns_left: turns_left - 1 }
  end

  def tally(_game) do
    1234
  end

  def maybe_won(true), do: :won
  def maybe_won(_),    do: :good_guess

end
