defmodule Cache.Application do

  use Application

  def start(_type, _args) do
    Cache.Fibonacci.start()
  end

end
