defmodule PcClient.Interact do

  def start() do
    guesses = ~w{a e i o u}

    Hangman.new_game("abcdef")
    |> play(guesses)
  end

  defp play(game, []), do: game

  defp play(game, [ current_guess | remaining_guesses ]) do
    hangman_game = { game, tally } = Hangman.make_move(game, current_guess)
    IO.inspect hangman_game

    should continue?
        if so, play next guess
        if not, exit?

  end

end
