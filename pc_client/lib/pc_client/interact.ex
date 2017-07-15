defmodule PcClient.Interact do

  def start() do
    guesses = "abcdefghijklmnopqrstuvwxyz"
              |> String.codepoints
              |> Enum.shuffle

    # Hangman.new_game("abcdef")
    Hangman.new_game()
    |> play(guesses)
  end

  defp play(game, []), do: game

  defp play(game, [ current_guess | remaining_guesses ]) do
    # hangman_game = { game, tally } = Hangman.make_move(game, current_guess)
    # IO.inspect hangman_game
    { game, tally } = Hangman.make_move(game, current_guess)

    # IO.inspect tally
    continue(game, tally, remaining_guesses)
  end

  defp continue(_game, tally = %{game_state: :lost}, _guesses) do
    IO.puts [
      "\n",
      "You lose",
      "\n",
      "Guessed letters so far: ",
      Enum.join(tally.letters, " "),
      "\n",
      "You used #{Enum.count(tally.used)} letters: ",
      Enum.join(tally.used, " "),
      "\n",
    ]
  end

  defp continue(_game, tally = %{game_state: :won}, _guesses) do
    IO.puts [
      "\n",
      "You win",
      "\n",
      "The word was: ",
      Enum.join(tally.letters, ""),
      "\n",
      "You used #{Enum.count(tally.used)} letters: ",
      Enum.join(tally.used, " "),
      "\n",
    ]
  end

  defp continue(game, _tally, guesses) do
    play(game, guesses)
  end

end
