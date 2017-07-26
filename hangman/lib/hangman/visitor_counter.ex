defmodule Hangman.VisitorCounter do

  @me __MODULE__

  def start_link do
    Agent.start_link(fn -> 0 end, name: @me)
  end

  def update_counts() do
    Agent.get_and_update(@me, fn count -> { count + 1, count + 1 } end)
  end

end
