defmodule Dictionary do

  def random_word do
    word_list()
    |> Enum.random()
  end

  def word_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__) # the file path is relative to the dir of this file
    |> File.read!()
    |> String.split(~r/\n/)
  end
end
