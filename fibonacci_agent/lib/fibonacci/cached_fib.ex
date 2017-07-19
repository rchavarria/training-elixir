defmodule FibonacciAgent.Calculator do

  alias FibonacciAgent.Cache

  def fib(agent, n) do
    fibs = Cache.get_fibs(agent)
    compute_fib(agent, n, Map.get(fibs, n))
  end

  defp compute_fib(agent, n, nil) do
    nth_fib = fib(agent, n - 1) + fib(agent, n - 2)
    fibs = Cache.get_fibs(agent)
    Cache.update_fibs(agent, Map.put(fibs, n, nth_fib))
    nth_fib
  end

  defp compute_fib(_agent, _n, computed), do: computed

end
