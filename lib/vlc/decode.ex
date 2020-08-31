defmodule Vlq.Decode do
  use Bitwise

  def decode(data) do
    <<value::size(8), data::binary>> = data

    continuation = 0x80 &&& value

    decode(continuation, value, data, [])
  end

  # continuation is set - more data
  defp decode(0x80, value, data, acc) do
    value = 0x7F &&& value

    <<next_value::size(8), data::binary>> = data
    continuation = 0x80 &&& next_value

    next_value = 0x7F &&& next_value

    decode(continuation, next_value, data, [value | acc])
  end

  # continuation is unset - no more data
  defp decode(0, value, _data, acc) do
    acc = [value | acc]
    acc = Enum.reverse(acc)
    length = length(acc) - 1

    # sum values shifting by 7 bits for each entry
    {total, _} =
      Enum.reduce(acc, {0, length}, fn entry, {total, index} ->
        entry = entry <<< (index * 7)

        {total + entry, index - 1}
      end)

    total
  end
end
