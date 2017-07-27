defmodule TextClient.Interact do

  @hangman_server :"hangman@ubuntuvm"

  alias TextClient.{ State, Player }

  def start() do
    new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally:        Hangman.tally(game),
    }
  end

  defp new_game() do
    # connect to the server, just in case
    Node.connect(@hangman_server)

    # make a RPC call, with the module, function and parameters way (MFA)
    :rpc.call(
      @hangman_server,
      Hangman,
      :new_game,
      []
    )
  end

end
