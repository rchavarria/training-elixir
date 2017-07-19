# Processes and maintaining state

## Why we're looking at this backwards

We're going to see processes from the bottom up. It's not easy to present them with real examples.

## Spawning a new process

There are two ways of spawning a proccess:

```
# spawn(fn)
spawn(fn ->
  Process.sleep(1000)
  IO.puts "Hello"
end)

# spawn(module, function, params)
spawn(MyModule, :my_function, [ "my", "params" ])
```

This form of module, function, arguments is called **M.F.A** in the elixir world.

**Remember**: Elixir processes are cheap. You can create one in less than 10µS, and each takes less than 3k of memory (including their initial heap and stack).

## Sending and receiving messages

It's done with `send`. It needs a *pid*.

`receive` waits for a message to arrive, binds it to a variable, then executes the associated code.

Messages sent to nonexistent processes are quietly thrown away.

Use recursion to implement a receiver loop in your process. In that recursion, we can pass ourselves the same state, and that's a way of keeping state in processes.

```
defmodule Procs do
  def greeter(count) do
    receive do
      msg -> #...
    end
    greeter(count)
  end
end
```

## Pattern matching messages

In the `receive` block we can do pattern matching.

```
receive do
  { :add, n } -> # ...
  { :del, n } -> # ...
  msg         -> # ...
end
```

## Linking our fate to our children's fate

By default, when a process fails, the *parent* process, the process who spawned it, is not notified. The spawning thing is *fire and forget*. Processes aren't linked to each other with `spawn`.

If we want some kind of linking, we use `spawn_link`. What it does, is that if the child process dies, the parent processs dies too.  But if the child process exits normally (`exit(:normal)`), the parent process doesn't die. That's how processes work in Erlang by default and that's why these systems are quite reliable.

## Agents-Simple state holders

Agents are an abstraction that keep state in a separate process.Class

You call `Agent.start_link` with a function to initialize the state.

`Agent.get(pid, func)` runs the function in the agent, passing it the state. The value returned by the function is the value returned by get.

`Agent.update(pid, func)` runs the function in the agent, passing it the state. The value returned by the function becomes the new state.

`Agent.get_and_update(pid, func)` runs the function with the state. The function should return a two-element tuple containing the return value to be passed to the caller and the updated state.

A Personal Rant About Naked Agents

But they are also open to abuse. In particular, an agent contains just state—all functions that work on that state are provided externally, in calls to get, update, and so on.

Because of this, I think it is crucially important to wrap every one of your agents inside a module, and only expose them through that module’s API.

```
defmodule HitCount do

  def start() do
    Agent.start_link(fn -> 0 end)
  end

  def record_hit(agent) do
    Agent.update(agent, &(&1 + 1))
  end

  def get_count(agent) do
    Agent.get(agent, &(&1))
  end

end
```

The use of an agent is an *implementation detail*. **It should never leak into the rest of your code**.

