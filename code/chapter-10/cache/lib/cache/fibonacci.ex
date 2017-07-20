defmodule Cache.Fibonacci do

  @me __MODULE__

  def start() do
    Agent.start_link(&initial_state/0, name: @me)
  end

  defp initial_state() do
    %{
      0 => 0,
      1 => 1,
    }
  end

  def lookup(n, compute_value_to_cache_it) do
    Agent.get(@me, fn sequence -> sequence[n] end)
    |> compute_if_not_exists(n, compute_value_to_cache_it)
  end

  defp compute_if_not_exists(nil, n, computation) do
    computation.()
    |> add_value_for(n)
  end

  defp compute_if_not_exists(value_to_cache, _n, _computation), do: value_to_cache

  defp add_value_for(fibonacci, n) do
    Agent.get_and_update(@me, fn sequence ->
      { fibonacci, Map.put(sequence, n, fibonacci) }
    end)
  end

end
