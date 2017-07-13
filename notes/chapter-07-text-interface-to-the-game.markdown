# Text interface to the game

## Intro

## Create the project

In the new project, we're going to create a text based client for the hangman game.

That application will create a new game, get the state and it'll have a `play` method. That method will interact with hangman game one turn at a time. At the end of the interactions of one turn, it'll call itself (recursively). This is how lots of apps in elixir work.

**Trick**: `IO.inspect` returns whatever you pass it, so you can put one in the middle of a pipeline

```
something
|> String.capitalize
|> String.codepoints
|> IO.inspect
|> String.downcase
|> IO.inspect
|> String.foobar
|> IO.inspect
|> String.capitalize
```

Try to divide code into modules, where each is responsible for one aspect of the overall application. Within each module, try to write functions that each perform just one transformation of state.

Put state that’s shared into its own module

## Write the main player

## Finish up

