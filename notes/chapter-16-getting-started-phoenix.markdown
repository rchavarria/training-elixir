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

- `assets` is where CSS and JS code will live
- `lib` is where our Elixir code will be. It contains a `<project name>` dir for our project code.
- `lib/project/web`, it has `controllers`, `views`, `templates`,... Tipical in a web app

The code for the server lives under `lib/gallows/web`.

```
lib
│
└── gallows
│
├── application.ex                <- normal application entry point 
│
└── web
│
├── channels
│   │
│   └── user_socket.ex
│
├── controllers
│   │
│   └── page_controller.ex    <- handle specific requests
│
├── endpoint.ex               <- entry point for communications
│
├── gettext.ex
│
├── router.ex                 <- send requests to correct controller/function
│
├── templates
│   │
│   ├── layout
│   │   │
│   │   └── app.html.eex      <- app-wide web page layout
│   │
│   └── page
│       │
│       └── index.html.eex    <- per request page layout
│
├── views
│   │ 
│   ├── error_helpers.ex
│   │
│   ├── error_view.ex
│   │
│   ├── layout_view.ex
│   │
│   └── page_view.ex          <- support code for templates
│
└── web.ex
```

**Templates and EEx**

EEx stands for Embedded Elixir. It is a preprocessor that looks for occurrences of `<% . . . %>` sequences in text. EEx comes standard with Elixir—you do not need Phoenix to run it.

The most common use is to evaluate an Elixir expression and put the resulting value back into the original string. This uses the <%= form of EEx substitution:

```
iex> EEx.eval_string ~s/hello <%= String.upcase("world") %>/
"hello WORLD"
```

This form of substitution can also handle more complex compound statements:

```
<%= if length(people) > 5 %>
"all y'all"
<% else %>
"y'all"
<% end %>
```

The else and end parts of the previous EEx template did not have an equals sign: <% else %> and not <%= else %>. That’s because the equals sign will always inject a value back into the original string. Here, the else and end do not generate values—they are simply part of the Elixir syntax.

The only variables available while executing the code in templates are those that you pass it:

```
iex> template = "the <%= animal %> says <%= sound %>"
"the <%= animal %> says <%= sound %>"
iex> EEx.eval_string(template, animal: "dog", sound: "woof")
"the dog says woof"
```

You can use the normal iteration constructs to loop through values:

```
iex> animals = ~w/ant bee cat/
["ant", "bee", "cat"]

iex> template = """ 
...> <%= for a <- list do %>
...>   the animal is <%= a %>
...> <% end %>
...> """
"<%= for a <- list do %>\n  the animal is <%= a %>\n<% end %>\n"

iex> IO.puts EEx.eval_string(template, list: animals)
the animal is ant

the animal is bee

the animal is cat
:ok
iex>
```

**Assigns**

You can also pass values into the template using the assigns mechanism. When you do this, you have to prefix the value with an at-sign in the template:

```
iex> EEx.eval_string "Hello <%= @place %>", assigns: [ place: "world" ]
"Hello world"
```

Phoenix uses this technique.

## Rendering

## Assigns and @variables

## Phoenix: a toolkit, not a framework

