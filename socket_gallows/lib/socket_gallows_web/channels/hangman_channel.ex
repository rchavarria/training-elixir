defmodule SocketGallowsWeb.HangmanChannel do
  require Logger

  use Phoenix.Channel

  # join callback
  def join("hangman:game", _, socket) do
    game = Hangman.new_game()

    # save the game state for this request. it's saved in the socket. if it were
    # an HTML request, it will be stored in the user's session
    socket = assign(socket, :game, game)

    # accepts the request of joining the channel
    { :ok, socket }
  end

  def handle_in("tally", _, socket) do
    game = socket.assigns.game
    tally = Hangman.tally(game)
    push(socket, "tally", tally)
    { :noreply, socket }
  end

  def handle_in(message, _, socket) do
    Logger.error("Error, message #{message} received from client")
  end

end
