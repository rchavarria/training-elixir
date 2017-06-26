# Chapter 04: Elixir types

## Integers and floats

Useful functions: `div`, `trunc` and `round`

## Atoms

They are constants. They could be considered as strings. In fact, you can create an atom like this `:"this is a string"`

## Booleans

Library `Bitwise` adds operations to bit level

```
iex> h Bitwise.
&&&/2   <<</2   >>>/2
...
iex> use Bitwise
Bitwise
iex> 1 <<< 10
1024
```

## Ranges

A bounded set of integers. It's interesting the use of the `in` operator

```
iex> a = 1..5
1..5
iex> 2 in a
true
```

## Strings (and Sigils)

A sigil is simply a notation for creating values from strings.

The sigils that come as part of Elixir are:
~c//  ~C//  list of character codes
~r//  ~R//  regular expression
~s//  ~S//  string
~w//  ~W//  list of words

An Elixir string is a sequence of Unicode codepoints.

Use the operator `<>` to concatenate strings.

## Regular expressions

Regular expressions are created with the sigil `r`: `~r/foo/gi`

The module `Regex` has lots of useful functions.

The operator `=~` can match a regexp.

## Tuples

## Lists

**Lists are not arrays**

An array is a contiguous area of memory containing fixed size cells. If you want to find the nth element in a array, you perform some simple address arithmetic:

```
a[2] = a + (element-size * index) = a + (element-size * 2)
```

And this is why programmers start counting at zero.

Lists are a sequence of zero of more elements, one linked to the next. It is easy to add a new element at the head of a list, and equally easy to remove that first element (called **head**).

Lists are a recursive data structure, and turn out to be well suited to a functional or declarative style.

## Maps

Maps are an unordered collection of key/value pairs. Both keys and values can be any Elixir type.

```
iex> my_map = %{ "key" => "value", ... }
# if keys are atoms, you can write it:
iex> my_map_atoms = %{ key: "value", key2: "value2",...}

# to acces them
iex> my_map["key"]
"value"
iex> my_map_atoms.key2
"value2"
```

There is a difference between `my_map["key"]` and `my_map_atoms.key`. If the `key` doesn't exist in the map, `my_map["key"]` returns `nil`, while `my_map_atoms.key` throws an exception/error.






