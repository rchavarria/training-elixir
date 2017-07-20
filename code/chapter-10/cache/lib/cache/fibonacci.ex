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

  def get_value_for(n) do
    Agent.get(@me, fn sequence -> sequence[n] end)
  end

  def add_value_for(fibonacci, n) do
    Agent.get_and_update(@me, fn sequence ->
      { fibonacci, Map.put(sequence, n, fibonacci) }
    end)
  end

end
