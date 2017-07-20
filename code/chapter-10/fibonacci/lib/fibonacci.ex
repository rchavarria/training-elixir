defmodule Fibonacci do

  def get(n) do
    n
    |> Cache.Fibonacci.get_value_for
    |> compute_if_not_exists(n)
  end

  defp compute_if_not_exists(nil, n) do
    get(n - 1) + get(n - 2)
    |> Cache.Fibonacci.add_value_for(n)
  end

  defp compute_if_not_exists(fibonacci, _n), do: fibonacci

end
