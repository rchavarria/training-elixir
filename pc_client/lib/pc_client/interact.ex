defmodule PcClient.Interact do

  def start() do
    Hangman.new_game("abcdef")
    |> play()
  end

  defp play(game) do
    hangman_game = { game, tally } = Hangman.make_move(game, "a")
    IO.inspect hangman_game
  end

end
