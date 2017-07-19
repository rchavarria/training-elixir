defmodule Dictionary.WordsOfLength do

  def words_of_length(words, len) do
    words |> Enum.filter(fn w -> String.length(w) == len end)
  end

end
