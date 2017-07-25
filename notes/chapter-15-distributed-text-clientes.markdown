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

## Start remote server when TextClient starts

