defmodule SocketGallowsWeb.HangmanChannel do
  use Phoenix.Channel

  # join callback
  def join("hangman:game", _, socket) do
    # accepts the request of joining the channel
    { :ok, socket }
  end

end
