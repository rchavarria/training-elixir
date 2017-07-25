defmodule Chain do

  defstruct(
    next_node: nil,
    count: 99999999,
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
    # what kind of messages are we gonna receive
    receive do
      { :trigger, _list } -> 
        # IO.inspect list
        # :timer.sleep 500
        # `node()` returns the pid of the current node
        # send { :chainer, state.next_node }, { :trigger, [ node() | list ] }

        send { :chainer, state.next_node }, { :trigger, [] }
    end

    message_loop(%{ state | count: state.count - 1 })
  end

end
