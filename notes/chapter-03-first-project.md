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

