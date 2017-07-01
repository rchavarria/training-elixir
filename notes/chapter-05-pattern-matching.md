# Chapter 05: Pattern matching

`=` is not an assignment operator. It matches the left hand side (LHS) with the right hand side (RHS). They must be the same through pattern matching. If not, a `no match` error will arise. So, in the expression:

```
a = 1
```

`a` must be the same as `1`, so Elixir binds (not assigns) the value `1` to the variable `a`.

The special variable whose name is a single underscore is never bound by pattern matching.

## Pinning the Values of Variables

All variables on the LHS of a match are unbound before the match is made:

```
iex> first = 42
42
iex> { first, second } = { 42, 24 }
iex> first
42
# it works

iex> { first, second } = { 1, 2 }
iex> first
1

# it has changed because first was unbound before doing the pattern matching
```

To pin the value `42` to `first`, just use the *pin* operator `^`:

```
iex> first
42
iex> { ^first, second } = { 1, 2 }
** (MatchError) ....
```

## Pattern matching function calls

```
def func({ a, b }) do
  IO.puts "a = #{a}, b = #{b}"
end
```

When `func` is called `func({ 1, 2 })`, `a` is bound to `1` and `b` to `2`.

A similar function:

```
def func(t = { a, b }) do
  IO.puts "a = #{a}, b = #{b}, is_tuple{t}"
end
```

The following function will only work if it's called with a tuple whose first element is the atom `:ok`.

```
def read_file({ :ok, file }) do 
  ...
end
```

Multiple function heads: functions can be overloaded based on the patterns their parameters match:

```
def read_file({ :ok, file }) do 
  file
  |> IO.read(:line)
end

def read_file({ :error, reason }) do 
  Logger.error("File error: #{reason}")
  []
end

...

"my_file.txt"
|> File.open
|> read_file  # I don't care if it succeeded or not
```

Pattern matching in parameter lists means we can take functions that would otherwise be a mess of nested conditional logic and rewrite them as a set of small, focused functions, each of which handles just one particular flow.

**This is a major win. It makes code easier to write, and easier to read. And code that is easier to read is easier to change. And that’s what good design is.**

## Lists and recursion

Implement functional methods for plain Lists:

```
defmodule Lists do

  def len([]), do: 0
  def len([_|t]), do: 1 + len(t)

  def sum([]), do: 0
  def sum([h|t]), do: h + sum(t)

  def double([]), do: []
  def double([ h|t ]), do: [ 2*h | double(t) ]

  def square([]), do: []
  def square([ h|t ]), do: [ h*h | square(t) ]

  def sum_pairs([]), do: []
  def sum_pairs([ h1, h2 | t ]), do: [ h1 + h2 | sum_pairs(t) ]

  def even_length?([]), do: true
  def even_length?([ h1, h2 | t ]), do: true && even_length?(t)
  def even_length?([ h2 | t ]), do: false

end
```

