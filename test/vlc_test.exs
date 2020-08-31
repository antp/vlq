defmodule VlqTest do
  use ExUnit.Case
  use ExUnitProperties

  doctest Vlq

  property "Ensure it encodes and decodes over a range of values" do
    check all value <- resize(positive_integer(), 5_000_000), max_runs: 10_000 do
      assert value == value |> Vlq.encode() |> Vlq.decode()
    end
  end
end
