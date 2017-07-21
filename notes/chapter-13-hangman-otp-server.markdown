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

## Other people write this differently

