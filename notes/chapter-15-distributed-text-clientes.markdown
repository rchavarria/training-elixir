# Distributed text clients

## A quick API change

The change to using a separate process in the Hangman application broke nothing, just a small change in the API that needs a small correction in `lib/text_client/mover.ex`. Great!

## From server to service

What does he mean with *Service*? Right now, when a client starts a Hangman game, it runs in the same node. The dictionary might run in a different node, and only one instance of the application is running. Instead, we have an instance of Hangman for each client.

He wants Hangman game to run in different nodes than clients.

Why does he want Hangman games to run in a different node? 

1. Server might need to access some resources (database) that should not be exposed to clients
2. Must be secure
3. Might have different deployment characteristics: deployment to the cloud, lots of memory, lots of cpu,...
4. Your clients are very simple and they don't have capacity

## Use Hangman API without starting a server

We’re about to fix a problem that doesn’t exist in most languages.

The code for the Hangman application does two things. First, it is the server process that plays the game. Second, it is the API code that interfaces between the client and that server process. This API code is like a conventional library—it runs in the client’s process and uses `GenServer.call` to forward requests on to the Hangman process.

Now we want to run the Hangman server in a separate node. Clearly, that node needs to be running the Hangman application. But we also need the API for Hangman in each of the client nodes. We need to find a way to include the Hangman code without also including a running server process. Let's see that in the video.

Maybe, the biggest change is that we don't want to start the Hangman server when a client uses it, or starts playing

In `mix.ex`, we have Hangman as a dependency, and `mix` starts any dependency that is also an Application. The `included_applications` key in the `applications` list (in `mix.ex`) tells Elixir to load the code for an application, but also tells it not to start that application.

## Start remote server when TextClient starts

TextClient creates a new game with `Hangman.new_game()`. But it creates the Hangman server in the same node.

To start it in another node, let's see we have a node where Hangman server is running and we know the name of the node, for example, it's running on `:"hangman@virtualized-ubuntu"`

**What We Saw**

Erlang’s [rpc library](http://erlang.org/doc/man/rpc.html) allows us to call functions in other (connected) nodes.

`Hangman.new_game` returns a pid. Because this return value crosses a node boundary, the runtime will automatically include the node ID in it. Calls made using that will will automatically run in the Hangman server’s node.

**What We Didn’t See**

I had to assume I had a running Hangman server, and I had to start it manually from the command line. This isn’t the basis of a reliable, scalable system. What’s missing is a kind of substrate that can be used to connect all these parts. And that’s what the rest of the course covers.

We’re about to start looking at the Phoenix framework. Many people view Phoenix as a web framework. I think this is wrong. In my view, Phoenix is actually a **really good switch**, exchanging data between clients and servers, and between servers themselves. **It makes it easy to connect things**.

