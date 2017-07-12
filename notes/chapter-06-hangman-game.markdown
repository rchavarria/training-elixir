# Chapter 06, Write the Hangman game

We’re going to be strict about separating the API from the implementation. And we’re going to try to enforce a rule that every function body does just one thing. Putting it another way, **each function body is responsible for just a single transformation** (SRP or Single Responsability Principle)

Good programmers **use muscle memory to handle all the low-level jobs**, leaving their conscious brains free to think about loftier things, such as design. And the only way to build programming muscle memory is by programming. So, please, code along while you watch the videos.

## Create the application

`mix new hangman`, as you might guess

Edit `mix.ex`:

```
def deps do
  [
    { :dictionary, path: "../dictionary" },
  ]
end
```

Adding a new dependency, to our `Dictionary` application

Get dependencies with `mix deps.get`.

Before, we defined a dependency that is in the local file system, in a `path:`, but there are other ways:

```
def deps() do
  [
    { :fetcher,  git: "https://repo.acme.com/fetcher", tag: "1.7" },
    { :pusher,   github: "pragdave/pusher" },
    ## Hex dependency
    { :earmark, "~> 1.0.0 },
  ]
end
```

## Think about the API

In Elixir, we write our code as a group of separate applications. That isolation is one of the reasons that Elixir code is both easy to change and incredibly reliable. But that means that APIs become crucially important.

In our hangman game, multiple clients can be using the Game server at the same time. In order to keep each client separate, the Game app passes a unique (and theoretically opaque) value to identify each separate state.

When a client needs the services on the game, it calls an API function (new_game in our case) to create a new state. The game then returns a token to the client that represents this state. In the current version of our app, this token is the actual state itself, but the client cannot rely on this. Once the client has the token that represents the game state, it passes it to all the successive API calls. Each call to the API might modify the state or token. The client must use this updated values when calling the API.

Public methods of the API will be available only in `lib/hangman.ex`. They will delegate to *private* code in subdirectories of `lib/`.

## Start coding

`defdelegate new_game(), to: Game` helps decoupling your code (in the API for example) to the implementation

Lots of code writen here: `Hangman`, `Hangman.Game` modules

## And start testing

- Tests are located in the test/ subdirectory.

The structure of a test file is

    defmodule SomeTest do 
      use ExUnit.Case
        
      test "a description of the test's purpose" do
        # Elixir code
      end
    end

## Pattern matching game state

Pattern matching can replace conditional code in your functions.

Patterns can match at many levels. For example, in

    def make_move(game = %{ game_state: :won }, _guess)

A `when` clause (also called a *guard* clause) can further restrict when a particular variant of a function can be called. The `when` is executed after the parameters are bound, so the values of parameters can be used.

    def make_move(game = %{ game_state: state }, _guess) when state in [:won, :lost] do

When I (Dave) code, I try to avoid conditional logic inside functions. Initially this was an experiment, but over time I’ve come to realize that this technique has improved the maintainability of my code.

Fortunately, Elixir’s pattern matching supports a style of coding functions that can be largely condition free. When you write Elixir code, try to use this style. Writing in this style is slightly more verbose, but the code you produce is easier to understand, test, and change.

## Check for duplicate moves

Try to give each function body a single purpose. Conditional statements are an indication that you’re doing two things. Fixing this will sometimes involve writing a new helper function. This is a *good thing*.

Implement the same, but with a `List` instead of a `MapSet`. Has it been too complicated? What are the differences?

It wasn't too complicated. The difference might be just the performance if you don't check for duplicates in the `List`. 

## Score a good move

Elixir has a `for` keyword, but it isn’t like `for` in other languages, it isn’t really a loop.

A basic comprehension looks like

```
result = for pattern <- collection do
end
```

Each element of the collection is matched against the `pattern`, and the `do` block is executed. The result of the `do` block is then added as the next element of the result list.

```
iex> for i <- 1..5 do
...>   i * 11
...> end
[11, 22, 33, 44, 55]
```

You can add more pattern/collection clauses to a for. It will nest the iterations such that the right iteration will be evaluated for each value on the left.

Any clause that isn’t `pattern <- collection` will be treated as a predicate. It will be evaluated, and if falsey, this particular iteration will be abandoned and the next started.

The `for` comprehension will generate a list by default. You can override this using the `into:` option, which lets you specify any kind of collection. 

```
iex> for name <- ~w{one two three}, val <- 1..3, into: %{}, do: { name, val }
%{"one" => 3, "three" => 3, "two" => 3}

iex> for str <- ~w{oNE Two tHrEe}, into: %{}, do: { String.downcase(str), str }
%{"one" => "oNE", "three" => "tHrEe", "two" => "Two"}

iex> for v <- ~w{ buckle my shoe }, into: [ 1, 2 ], do: v
[1, 2, "buckle", "my", "shoe"]
```

Exercise with Pythagorean triangles (a^2 + b^2 = c^2):

```
:timer.tc(fn ->
  for a <- 1..100, b <- (a+1)..100, c <- (b+1)..100, c*c == a*a + b*b, do: { a, b, c }
end) |> IO.inspect
```

## Score a bad guess

**Beaware of comprehensions**: The body of a comprehension is effectively the body of a function—it is called multiple times as the comprehension processes its collections. As a result, the values of variables in the scope that surrounds the comprehension are available inside (in the same way that the values would be captured by a function body). However, **changing the value of a variable inside the comprehension changes just that local copy**—the outer scope is not touched.

For example:

```
iex> sum = 0
0

iex> for i <- 1..10, do: sum = sum + i
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# sum is not modified
iex> sum
0
```


