# Our first project

## Introduction

No es obligatorio, pero ayuda a tener una estructura de proyecto similar a la recomendada. De esa forma, `mix` te ayudará un montón.

## Create new project

Para crear un nuevo proyecto... `mix new <nombre del proyecto>`

Tu código va en el directorio `lib`. El código de los tests en `test`

`mix.exs` es donde se configura el proyecto

Para compilar la aplicación... `mix`

`mix help` te dice todos los comandos disponibles con `mix`

`iex -h` muestra la ayuda de `iex`

## Run some code

`mix run -e <some code>` runs some code

`iex -S mix` starts `iex` in the context of your project

Inside `iex`: `r MyModule` reloads the module. `c "lib/mymodule.ex" recompiles the file

## Write the dictionary module

[Exercise](https://gist.github.com/pragdave/b531661aed905172d2c833a100af29f2) about this unit

## Refactor into pipelines

OO has methods, FP (functional programming) has functions

Drawbacks of OOP:

1. there is a strong coupling between state and behaviour
2. the state stored in a class is tied to the logic of that class. if you need the state for another role, you need to extend the class (mixins, subclassing,...)
3. methods mutate object state. that's bad in concurrent systems

Functions and state in elixir

- State is inmutable
- Functions transform a state into another state

Our main tools are *functional composition* and *pattern matching*

**Functional composition** the output of one is the input of the next function

**Pattern matching** lets you write different versions of the same function

The pipeline operator `|>`: When you’re just starting out with Elixir, try to make yourself use pipelines all the time. Try to avoid local variables

## Onward!



