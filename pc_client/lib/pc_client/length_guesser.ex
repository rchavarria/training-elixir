defmodule PcClient.LengthGuesser do

  def next_guess(nil) do
    "abcdefghijklmnopqrstuvwxyz"
    |> String.codepoints
    |> Enum.shuffle
    |> Enum.at(0)
  end

  def next_guess(tally) do
    tally.letters
    |> Enum.count
    |> Dictionary.words_of_length
    # |> IO.inspect
    |> Enum.reduce(MapSet.new, fn word, letters ->
      MapSet.union(letters, MapSet.new(String.codepoints(word)))
    end)
    # |> IO.inspect
    |> MapSet.difference(tally.used)
    |> Enum.shuffle
    |> Enum.at(0)
  end

end
