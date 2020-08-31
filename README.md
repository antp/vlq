# Vlq

An implementation of Variable Length Quantity

From [wikipedia](https://en.wikipedia.org/wiki/Variable-length_quantity):

A variable-length quantity (VLQ) is a universal code that uses an arbitrary
number of binary octets (eight-bit bytes) to represent an arbitrarily large
integer. A VLQ is essentially a base-128 representation of an unsigned
integer with the addition of the eighth bit to mark continuation of bytes.



## Installation

```elixir
def deps do
  [
    {:Vlq, github: "antp/Vlq"}
  ]
end
```

## Not on Hex?

Nope, the code is not complicated.
Do you really need to pull this library in?

Why not just take it and put it in your project and have one less dependency!

## Usage

~~~elixir
iex> Vlq.encode(128)
# <<129, 0>>

iex> Vlq.decode(<<129, 0>>)
# 128



