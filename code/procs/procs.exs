defmodule Procs do

  def greeter(what_to_say) do
    receive do
      msg ->
        IO.puts "#{what_to_say}: #{msg}"
    end
   
    # create a recursive loop to have the process alive forever
    greeter(what_to_say)
  end

end
