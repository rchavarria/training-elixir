defmodule SocketGallows.Web.HangmanChannel do

  use Phoenix.Channel

  require Logger
  
  def join("hangman:game", _, socket) do
    socket = socket |> start_game()
    {:ok, socket }
  end

  def handle_in("tally", _, socket) do
    tally = socket.assigns.game |> Hangman.tally()
    push(socket, "tally", tally)
    { :noreply, socket }
  end
  
  def handle_in("make_move", guess, socket) do
    tally = socket.assigns.game |> Hangman.make_move(guess)
    push(socket, "tally", tally)
    { :noreply, socket }
  end

  def handle_in("new_game", _, socket) do
    socket = socket |> start_game()
    handle_in("tally", nil, socket)
  end

  defp start_game(socket) do
    Logger.info "[INFO] Creating a new game (joining or new)"
    Process.send_after(self(), {:tick, 59}, 1000)
    socket |> assign(:game, Hangman.new_game())
  end

  def handle_info({:tick, 0}, socket) do
    Logger.info "[INFO] Tick has ended"
    push(socket, "tick", %{ seconds_left: 0 })

    tally = socket.assigns.game |> Hangman.tally()
    tally = %{ tally | game_state: :lost_timeout }
    push(socket, "tally", tally)

    { :noreply, socket }
  end

  def handle_info({:tick, seconds_left}, socket) do
    Logger.info "[INFO] Received #{seconds_left} seconds left"
    push(socket, "tick", %{ seconds_left: seconds_left })
    Process.send_after(self(), {:tick, seconds_left - 1}, 1000)
    { :noreply, socket }
  end
  
end
