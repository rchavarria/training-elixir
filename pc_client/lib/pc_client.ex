defmodule PcClient do

  defdelegate start(), to: PcClient.Interact

end
