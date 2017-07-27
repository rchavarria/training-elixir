defmodule Hangman.Server do

  alias Hangman.Game

  use GenServer

  def start_link() do
    {:ok, pid } = GenServer.start_link(__MODULE__, nil)
    Process.monitor(pid)
    {:ok, pid }
  end

  def init(_arguments) do
    # :ok = :net_kernel.monitor_nodes(true)
    Process.flag(:trap_exit, true)
    game = Game.new_game()
    # init must return a tuple, :ok and GenServer's state
    { :ok, game }
  end

  # state is the `game` that saves the GenServer
  def handle_call({ :make_move, guess }, _from, game) do
    { game, tally } = Game.make_move(game, guess)

    # return a reply, the tally will be returned to the caller and
    #game will be the new GenServer state
    { :reply, tally, game }
  end

  # state is the `game` that saves the GenServer
  def handle_call({ :tally }, _from, game) do
    { :reply, Game.tally(game), game }
  end

  def handle_info({:nodedown, node}, game) do
    remaining_nodes = Hangman.NodeNames.delete_node(node)
    IO.puts "Node #{node} disconnected, remainning nodes are #{inspect remaining_nodes}"
    {:noreply, game}
  end

  def handle_info({:UP, ref, _process, pid, _reason}, game) do
    IO.puts "Detected a UP message where ref: #{inspect ref}, pid #{inspect pid}"
    {:noreply, game}
  end

  def handle_info({:DOWN, ref, _process, pid, _reason}, game) do
    IO.puts "Detected a DOWN message where ref: #{inspect ref}, pid #{inspect pid}"
    {:noreply, game}
  end

  def handle_info(msg, game) do
    IO.puts "Unexpected message: #{inspect msg}"
    {:noreply, game}
  end

  def terminate(_reason, _game) do
    IO.puts "Terminating my GenServer"
  end

end
