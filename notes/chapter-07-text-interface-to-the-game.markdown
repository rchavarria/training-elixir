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

What We Did

Using the name of a structure when pattern matching a parameter is a form of type checking. I use the technique a lot when I’m first starting on a project, and I’m not yet 100% sure of my APIs.

Using pattern matching and multiple function heads lets you build your code step by step. You don’t need all the functionality in place to be able to compile and test. And it's much better than an `if` or a `case`.

We used an indirect recursive call (play calls continue calls play) to get successive move. We pass the updated state through this sequence, so we can track the game as it progresses.

## Finish up

We used pattern matching to handle the checking of the error conditions potentially returned by `IO.gets`

The `cond` expression lets you write a series of conditions, each with some code. The code associated with the first matching condition is executed, and its value becomes the value of the `cond`.



