defmodule Hangman.NodeNames do

  @me __MODULE__

  def start_link do
    Agent.start_link(fn -> [] end, name: @me)
  end

  def update_names() do
    remote_node = remote_node_name()
    Agent.get_and_update(@me, fn names ->
      names = [ remote_node | names ] 
      { names, names }
    end)
  end

  defp remote_node_name() do
    { :group_leader, gl } = :rpc.pinfo(self())
                            |> Enum.find(fn info -> match?({:group_leader, _}, info) end )
    
    node(gl)
  end

end

