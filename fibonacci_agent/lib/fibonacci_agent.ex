defmodule FibonacciAgent do

  alias FibonacciAgent.{Calculator, Cache}

  def fib(n) do
    { :ok, agent } = Cache.start()
    Calculator.fib(agent, n)
  end

end
