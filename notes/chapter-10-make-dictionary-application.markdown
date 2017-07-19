# Make Dictionary a free standing application

## What is an Application?

An Elixir project can be a plain library, which is just code. It has no independent existence.

A project can also be an application, which means it runs in its own process, and has its own state.

In reality, a typically application will be something of a hybrid. It will have code that runs in the context of its own processes. It will also have code that is called directly from other applications, and which runs in their processes. This is the interface from the application to the outside world.

## Wrap the dictionary


