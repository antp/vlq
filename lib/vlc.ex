defmodule Vlq do
  @moduledoc """

  A variable-length quantity (VLQ) is a universal code that uses an arbitrary
  number of binary octets (eight-bit bytes) to represent an arbitrarily large
  integer. A VLQ is essentially a base-128 representation of an unsigned
  integer with the addition of the eighth bit to mark continuation of bytes.


  """

  @doc """
  Encode.

  Encode an none negative integer value to a VLQ binary

  ## Examples

      iex> 0 |> Vlq.encode()
      <<0>>

      iex> 128 |> Vlq.encode()
      <<129, 0>>

      iex> 256 |> Vlq.encode()
      <<130, 0>>

      iex> 32766 |> Vlq.encode()
      <<129, 255, 126>>
  """
  defdelegate encode(data), to: Vlq.Encode

  @doc """
  Decode.

  Decode a VLQ binary to a none negative integer value

  ## Examples

      iex> <<0>> |> Vlq.decode()
      0

      iex> <<129, 0>> |> Vlq.decode()
      128

      iex> <<130, 0>> |> Vlq.decode()
      256

      iex> <<129, 255, 126>> |> Vlq.decode()
      32766
  """
  defdelegate decode(data), to: Vlq.Decode
end
