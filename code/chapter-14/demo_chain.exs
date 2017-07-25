defmodule Chain do

  defstruct(
    next_node: nil,
    count: 10,
  )

  def start_link(next_node) do
    spawn_link(Chain, :message_loop, [ %Chain{ next_node: next_node } ])
    |> Process.register(:chainer)
  end

  # end of the message loop
  def message_loop(%{ count: 0 }) do
    IO.puts "I'm done"
  end

  def message_loop(state) do
    receive do
      { :trigger, msg } -> 
        msg_to_send = msg |> String.reverse
        IO.puts [
          "\n",
          "Old: ",
          msg,
          ", new: ",
          msg_to_send,
          "\n"
        ]
        :timer.sleep 500

        send { :chainer, state.next_node }, { :trigger, msg_to_send }
    end

    message_loop(%{ state | count: state.count - 1 })
  end

end
