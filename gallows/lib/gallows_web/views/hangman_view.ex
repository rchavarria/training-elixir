defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def word_so_far(tally) do
    tally.letters |> Enum.join(" ")
  end

end
