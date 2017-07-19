defmodule FibonacciAgent.Cache do

  def start do
    Agent.start_link(fn -> %{ 0 => 0, 1 => 1 } end)
  end

  def get_fibs(agent) do
    Agent.get(agent, &(&1))
  end

  def update_fibs(fibs, agent) do
    Agent.get_and_update(agent, fn _ -> { fibs, fibs } end)
  end

end
