# Getting started with Phoenix

## Introduction

Most of the people creates a Phoenix project and place their code inside it (in fact, Phoenix provides you a place for that). We're going to see Phoenix just as a new client for our Hangman app, running in a different node.

## Installing Phoenix (and a rant)

`mix archive.install` installs extensions to `mix` in your local user folder

Use it to install Phoenix:

    mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez

`mix archive` list all your installations

Create a new Phoenix project with `mix phx.new`

Run the Phoenix server with `mix phx.server`

**Rant**: Phoenix comes with Ecto and lots/tons of JavaScript code. 90% of a Phoenix project is not Phoenix code. I strongly suggest you fight the temptation to stick everything in the Phoenix app. As we’ve been building our hangman game, we’ve been working hard to build code into separate, well defined applications. We’ll continue to do this as we add Phoenix integration.

## Project structure



## Rendering

## Assigns and @variables

## Phoenix: a toolkit, not a framework

