defmodule Dictionary.WordList do

  def start, do: word_list()

  def start_link do
    Agent.start_link(&word_list/0)
  end

  def random_word(agent) do
    Agent.get(agent, &Enum.random/1)
  end

  defp word_list do
    "../../assets/words.txt"
    |> Path.expand(__DIR__) # the file path is relative to the dir of this file
    |> File.read!()
    |> String.split(~r/\n/)
  end

end
