defmodule PcClient.RegexGuesser do

  def next_guess(nil) do
    "abcdefghijklmnopqrstuvwxyz"
    |> String.codepoints
    |> Enum.shuffle
    |> Enum.at(0)
  end

  def next_guess(tally) do
    {:ok, re} = Regex.compile(tally.letters |> Enum.map(&to_regex/1) |> Enum.join)

    tally.letters
    |> Enum.count
    |> Dictionary.words_of_length
    |> Enum.filter(fn word ->
      Regex.match?(re, word)
    end)
    |> Enum.reduce(MapSet.new, fn word, letters ->
      MapSet.union(letters, MapSet.new(String.codepoints(word)))
    end)
    |> IO.inspect
    |> MapSet.difference(tally.used)
    |> Enum.shuffle
    |> Enum.at(0)
  end

  defp to_regex("_"), do: "."
  defp to_regex(x), do: x

end

