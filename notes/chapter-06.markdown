# Chapter 06, Write the Hangman game

We’re going to be strict about separating the API from the implementation. And we’re going to try to enforce a rule that every function body does just one thing. Putting it another way, **each function body is responsible for just a single transformation** (SRP or Single Responsability Principle)

Good programmers **use muscle memory to handle all the low-level jobs**, leaving their conscious brains free to think about loftier things, such as design. And the only way to build programming muscle memory is by programming. So, please, code along while you watch the videos.

## Create the application

`mix new hangman`, as you might guess

Edit `mix.ex`:

```
def deps do
  [
    { :dictionary, path: "../dictionary" },
  ]
end
```

Adding a new dependency, to our `Dictionary` application

Get dependencies with `mix deps.get`.

Before, we defined a dependency that is in the local file system, in a `path:`, but there are other ways:

```
def deps() do
  [
    { :fetcher,  git: "https://repo.acme.com/fetcher", tag: "1.7" },
    { :pusher,   github: "pragdave/pusher" },
    ## Hex dependency
    { :earmark, "~> 1.0.0 },
  ]
end
```

## Think about the API

In Elixir, we write our code as a group of separate applications. That isolation is one of the reasons that Elixir code is both easy to change and incredibly reliable. But that means that APIs become crucially important.

In our hangman game, multiple clients can be using the Game server at the same time. In order to keep each client separate, the Game app passes a unique (and theoretically opaque) value to identify each separate state.

When a client needs the services on the game, it calls an API function (new_game in our case) to create a new state. The game then returns a token to the client that represents this state. In the current version of our app, this token is the actual state itself, but the client cannot rely on this. Once the client has the token that represents the game state, it passes it to all the successive API calls. Each call to the API might modify the state or token. The client must use this updated values when calling the API.

Public methods of the API will be available only in `lib/hangman.ex`. They will delegate to *private* code in subdirectories of `lib/`.

## Start coding

`defdelegate new_game(), to: Game` helps decoupling your code (in the API for example) to the implementation

Lots of code writen here: `Hangman`, `Hangman.Game` modules

## And start testing

- Tests are located in the test/ subdirectory.

The structure of a test file is

    defmodule SomeTest do 
      use ExUnit.Case
        
      test "a description of the test's purpose" do
        # Elixir code
      end
    end

## Pattern matching game state




