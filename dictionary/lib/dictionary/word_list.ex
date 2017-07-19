defmodule Dictionary.WordList do

  def start, do: word_list()

  def random_word(words) do
    words |> Enum.random()
  end

  defp word_list do
    "../../assets/words.txt"
    |> Path.expand(__DIR__) # the file path is relative to the dir of this file
    |> File.read!()
    |> String.split(~r/\n/)
  end

end
