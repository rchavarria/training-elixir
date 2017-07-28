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

**Helpers**

Don't get used to Elixir code in templates, use helper functions for that. The virtuous developer, though, will make such code into helper functions, and place it in a module in the views/ directory.

A naming convention links controllers, views and templates. If I render `index.html` from within the `PageController`, the actual work of rendering will be handed off to the `PageView` module. Any functions defined in this module will be available in any template it renders. The view will then look for the template file itself in `templates/page/index.html.eex` and invoke `EEx` on it, passing in any assigns.

In general, if the `AbcController` is handling a request, and it renders `xyz.html`, then the view logic will be handled by `views/abc_view` and the template in `templates/abc/xyz.html.eex` will be rendered. All these defaults can be overridden.

Also, remember that helpers are just functions. If you know the name of a helper’s module, you can call that helper using its fully-qualified name from any view. Also, you can import modules containing shared helper functions into any view.

## Rendering

The rendered HTML for a particular controller function is wrapped in an outer template before being sent back to the browser. This outer template typically includes all the page housekeeping (the <head> section, the basic page layout in the <body>, and the inclusion of all the assets. The default outer template is called app.html.eex. You can override this for particular controllers or controller functions.

**Assets and Brunch**

Brunch configuration is in `assets/brunch-config.js`. In a nutshell:

- Assets are built into `priv/static`.
- JavaScript files are built from `assets/js/app.js`, and the result is placed in `priv/static/js/app.js`.
- Stylesheets are read from `assets/css` and the result is concatenated into `priv/static/css/app.css`. If you want to create application-specific styles, start in `assets/css/app.css.
- Babel is run on all JavaScript outside the vendor tree. No CSS proprocessing is applied by default.
- All files in `assets/static` will be copied to `priv\static`.

All this asset juggling means that you can’t just slap a path to an image into a template and expect it to work when you deploy your app. Instead you use build in helper functions to create the appropriate asset paths for you.

For example, if you have an image of a wombat that’s just perfect for your home page, you could store the image file in your project tree in `assets/static/images/wombat.jpg`

Then, in your home page template, you’d reference it using: `<img src="<%= static_path(@conn, "/images/wombat.jpg") %>">`

## Assigns and @variables

A map or keyword list can be passed as the third parameter to render. It defines a set of variables that are then available in the template. These variables are called *assigns*.

Within the template, you access an assign by prefixing its name with a at-sign (`@produce`).

These variables are only available inside <%...%> constructs.

## Phoenix: a toolkit, not a framework

What it's not:

- A web framework
- Ruby on rails replacement

So, what's:

- A switch: get data from a connection and sends a response to another connection

Flow:

1. Incoming request
    1.a. add request id
    1.b. log row request
    1.c. parse content
    1.d. determine verb (get, post,...)
    1.e. decode session information
    1.f. route to handler
    1.g. **invoke app**: everything but this is the framework's job, this is **your** job
    1.h. format response
    
As a flow, it could be as if a `connection` passes through a pipeline. But Phoenix doesn't use pipelines, it uses something more flexible, *plugs* is called.

A *plug* is something very simple, it's what is known as a *reducer*. It takes two arguments: a connection and some options, and return a connection.

Everything starts with an external connection (user request). It passes through some plugs: endpoint, router, controller, view and template:

- Endpoint: it contains some specific plugs, depending on the connection: add request id, log request, parse content, determine verb, decode session information, route to...
- Router: it also contains some specific plugs, also depending on the connection type: match paths and methods, dispatch to a function in a...
- Controller: your code, it extracts args from request, invokes your application logic and renders a response
- View: it may contain some logic just for the view
- Tempalte: replace values into the page
- Browser. \o/

