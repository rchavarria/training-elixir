defmodule Fibonacci do

  def calc(n) do
    Cache.Fibonacci.lookup(n, fn ->
      calc(n - 1) + calc(n - 2)
    end)
  end

end
