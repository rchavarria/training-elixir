defmodule PcClient.Interact do

  alias PcClient.Guesser

  def start() do
    # Hangman.new_game("abcdef")
    Hangman.new_game()
    |> play_with_tally(nil)
  end

  defp play_with_tally(game, tally) do
    guess = Guesser.next_guess(tally)
    { game, tally } = Hangman.make_move(game, guess)
    continue_with_tally(game, tally)
  end

  defp continue_with_tally(_game, tally = %{game_state: :lost}) do
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

  defp continue_with_tally(_game, tally = %{game_state: :won}) do
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

  defp continue_with_tally(game, tally) do
    play_with_tally(game, tally)
  end

end
