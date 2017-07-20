# Make Dictionary a free standing application

## What is an Application?

An Elixir project can be a plain library, which is just code. It has no independent existence.

A project can also be an application, which means it runs in its own process, and has its own state.

In reality, a typically application will be something of a hybrid. It will have code that runs in the context of its own processes. It will also have code that is called directly from other applications, and which runs in their processes. This is the interface from the application to the outside world.

## Wrap the dictionary

Convert the Dictionary library into an application:

1. Add a `mod:` property to `application` function in `mix.ex`

```
def application do
  [
    mod: { Dictionary.Application, [] },
    applications: [:logger]
  ]
end
```

Where `Dictionary.Application` is the name of the module to be executed to run the application. It's usually placed in `lib/<application name>/application.ex`

2. Define that module

```
defmodule Dictionary.Application do

  use Application

  # if we want to link our Application to the global (parent) process
  # we can use `start_link` instead
  def start(_type, _args) do
    # it starts our agent
    Dictionary.WordList.start_link()
  end
end
```

`start/2` must return the tuple `{:ok, pid}` where `pid` is the process ID of the root of the application (well, in our case, we're returning the pid of the agent, not the pid of the application itself).

Then, instead of passing back the pid of our agent, we can give it a name:

```
defmodule Dictionary.WordList do

  # create a static variable at module level, it'll be the name of our agent
  @me __MODULE__

  def start_link do
    Agent.start_link(&word_list/0, name: @me)
  end

end
```

When asking the agent for it's state: `Agent.get(@me, fn ... end)`

