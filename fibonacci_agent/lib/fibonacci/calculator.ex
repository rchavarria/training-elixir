defmodule FibonacciAgent.Calculator do

  alias FibonacciAgent.Cache

  def fib(agent, n) do
    agent
    |> Cache.get_fibs
    |> Map.get(n)
    |> compute_fib(agent, n)
  end

  defp compute_fib(nil, agent, n) do
    nth_fib = fib(agent, n - 1) + fib(agent, n - 2)

    agent
    |> Cache.get_fibs
    |> Map.put(n, nth_fib)
    |> Cache.update_fibs(agent)
    |> Map.get(n)
  end

  defp compute_fib(computed, _agent, _n), do: computed

end
