defmodule TextClient.Prompter do

  def accept_move(game) do
    # IO.gets retunrs: `data` or `:eof` or `{:error, reason}`
    IO.gets("Your guess: ")
    |> check_input(game)
  end

  defp check_input({:error, reason}, _game) do
    IO.puts("Game ended: #{reason}")
    exit :normal
  end

  defp check_input(:eof, _game) do
    IO.puts("Looks like you gave up...")
    exit :normal
  end

  defp check_input(input, game) do
    input = String.trim(input)
    cond do
      # input matches the regex: starts (\A) with a lowercase and ends (\z), just one char
      input =~ ~r/\A[a-z]\z/ ->
        Map.put(game, :guess, input)

      # otherwise
      true ->
        IO.puts "Please enter a single lowercase letter"
        accept_move(game)
    end
  end

end
