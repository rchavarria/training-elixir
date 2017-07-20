# The story so far

## Supervisors and Servers

In our Dictionary application we have two processes: the Supervisor and the Agent that holds the state of the Dictionary.

Then, clients of our Dictionary will call the API. That will be a third process. The API won't call the supervisor. It doesn't care. It will call the Agent.

Where do we want to go? We have our Dictionary. We have our Game, and we have clients for the Game. Each Game will run in a separate process for each client. But, there'll be just one Dictionary, one for all clients.

Each client talks to its own Hangman process. The process **is** the state for that game. Clients will handle that *state* (the PID of the process)

Elixir calls these processes **servers**. An Agent (our Dictionary) is a kind of server.

**GenServer**

- Key part of the Erlang OTP framework
- Abstraction of a generic server
- Two sets of APIs:
    - External API, to control the server. Its code runs in the client process (start, invoke, monitor, stop)
    - Internal API, or callbacks, the server itself. Its code runs in the server process (initialize, handle requests, handle events)

In the calling process, we'll have code such as:

```
// starting the server
{ :ok, pid } = GenServer.start_link(GameServer, args)

// invoking the server
return_value = GenServer.call(pid, { :make_move, "a" })
```

On the server process, we'll have:


```
defmodule GameServer do
  use GenServer

  def init(args) do
    state = create_initial_state(args)
    { :ok, state }
  end

  // we do pattern matching in the first argument, to select what messages we want to handle
  // the third arg is the current state of the server
  def handle_call({ :make_move, guess }, _from, state) do
    # make the move and update the state
    # ...

    # reply with: the value to return to `GenServer.call` and the new state of the server
    { :reply, return_value, new_state }
  end

end
```




