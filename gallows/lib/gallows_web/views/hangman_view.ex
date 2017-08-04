defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import Gallows.Views.Helpers.GameStateHelper

  def word_so_far(tally) do
    tally.letters |> Enum.join(" ")
  end

  def used_letters(tally) do
    tally.used |> Enum.join(", ")
  end

  def new_game_button(conn) do
    button("New game", to: hangman_path(conn, :create_game))
  end

  def game_over?(%{ game_state: state }) do
    state in [ :won, :lost ]
  end

  def turn(left, target) when target < left, do: "dim"
  def turn(_left, _target), do: ""

end
