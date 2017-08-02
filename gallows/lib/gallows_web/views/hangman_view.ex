defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import Gallows.Views.Helpers.GameStateHelper

  def word_so_far(tally) do
    tally.letters |> Enum.join(" ")
  end

  def new_game_button(conn) do
    button("New game", to: hangman_path(conn, :create_game))
  end

  def game_over?(%{ game_state: state }) do
    state in [ :won, :lost ]
  end

end
