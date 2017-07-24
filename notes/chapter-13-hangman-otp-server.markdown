# Hangman, the OTP server

## Fixign a poor judgement call

It refactors the Hangman code from a function in the API with some logic, moving that logic to Hangman.Game, where it was in the first place

## Writing a Hangman GenServer

I like to keep the actual implementation separate from the code that is the server—the server is invoked from the API and then delegates processing to the implementation.

I also like to keep the API separate from the server.

You tell Elixir that a module implements the `GenServer` behaviour using the expression use `GenServer`. The use expression calls a macro in the given module (`GenServer` in this case). That macro generates code that is injected back into our module.

In the case of `GenServer`, the macro tells Elixir that our module can be used as a server, and defines default implementations of most of the callback functions.

The `start_link` function is called directly by code that want to kick off our server. It runs in the same process as that code. It calls `GenServer.start_link` which then starts the new server process.

Once that process is running, and before anything else happens, the `GenServer` framework calls the `init` function, which is responsible for returning the initial state.

`observer.start` is an easy way to look into your server (including the current state).

## Change the API to use the server

## A dynamic cloud of hangman servers

The easiest way of having our library/application supervised by a supervisor, is to make it an Application. Then, start a Supervisor from that Application.

If you know a new project is going to be an application, or to need a top-level supervisor, create it using the `--sup` flag. That creates a default supervised application for you.

```
$ mix new my_app --sup
```

The `simple_one_for_one` strategy is perfect for creating dynamic pools of the same server. When initialized a `simple_one_for_one` supervisor creates no server processes. Create a new servers with `Supervisor.start_child`. So, at the beginning, there'll be no servers. When clients start using them, they'll be created as supervised.

The Elixir documentation is always worth reading. The section covering [supervisors](https://hexdocs.pm/elixir/Supervisor.html) is particularly good.

## Other people write this differently

The rest of the world, would write Hangman game in a different way: they'll write the API (`/lib/hangman.ex`) the GenServer (`/lib/hangman/server.ex`) and the game implementation (`/lib/hangman/game.ex`) in the same file.

**Your Turn**

Create a new throwaway branch in your copy of the Hangman project, and reorganize it so that the API, implementation, and GenServer stuff is all in a single source file.

Go through that file and make every function definition that isn’t an API or a GenServer callback private. This is the way people would write this type of server.

Now update the tests to get them working.

