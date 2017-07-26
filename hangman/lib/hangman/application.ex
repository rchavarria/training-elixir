defmodule Hangman.Application do

  use Application

  def start(_type, _args) do
    # start monitoring nodes
    :ok = :net_kernel.monitor_nodes(true)

    # needed for some Supervisor features
    import Supervisor.Spec

    children = [
      worker(Hangman.Server, []),
    ]

    options = [
      name: Hangman.Supervisor,

      # this strategy `simple_one_for_one` means: do not start any worker yet, you'll start one
      # of them when a client ask for it. You'll start as many children as clients you have
      # If one of them crashes, just restart one, without affecting other
      strategy: :simple_one_for_one,

      # default values for not restarting indefinitely
      max_restarts: 1,
      max_seconds: 5,
    ]

    Supervisor.start_link(children, options)
  end

  def handle_info({ :nodeup, node }, game) do
    IO.puts "Node #{inspect node} is added"
    { :noreply, game }
  end

  def handle_info({ :nodedown, node }, game) do
    IO.puts "Node #{inspect node} is removed"
    { :noreply, game }
  end

  def handle_info(msg, game) do
    IO.puts "Received #{inspect msg}"
    { :noreply, game }
  end

end
