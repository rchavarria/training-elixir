defmodule Procs do

  def greeter(count) do
    receive do
      { :add, n } ->
        greeter(count + n)
      :reset ->
        greeter(0)
      msg ->
        IO.puts "#{count}: Hello #{inspect msg}"
        greeter(count)
    end
  end

end
