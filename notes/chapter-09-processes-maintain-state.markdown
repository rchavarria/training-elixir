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

## Agents-Simple state holders

