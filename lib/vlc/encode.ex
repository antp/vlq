defmodule Vlq.Encode do
  use Bitwise

  def encode(0) do
    <<0::size(8)>>
  end

  def encode(data) do
    data
    |> break_into_seven_bits([])
    |> encode_uint_values()
  end

  defp encode_uint_values(acc) do
    length = length(acc)

    {acc, _} =
      Enum.reduce(acc, {<<>>, length}, fn entry, {acc, length} ->
        acc =
          if length > 1 do
            value = 0x80 ||| entry
            acc <> <<value::size(8)>>
          else
            acc <> <<entry::size(8)>>
          end

        {acc, length - 1}
      end)

    acc
  end

  defp break_into_seven_bits(0, acc) do
    acc
  end

  defp break_into_seven_bits(data, acc) do
    value = 0x7F &&& data
    data = data >>> 0x7

    acc = [value | acc]

    break_into_seven_bits(data, acc)
  end
end
