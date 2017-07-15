defmodule PcClient.Guesser do

  def next_guess(nil) do
    "abcdefghijklmnopqrstuvwxyz"
    |> String.codepoints
    |> Enum.shuffle
    |> Enum.at(0)
  end

  def next_guess(tally) do
    "abcdefghijklmnopqrstuvwxyz"
    |> String.codepoints
    |> MapSet.new(fn x -> x end)
    |> MapSet.difference(tally.used)
    |> Enum.shuffle
    |> Enum.at(0)
  end

end
