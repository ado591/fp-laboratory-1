defmodule PythagorasStream do
  @moduledoc "stream solution"
  @sum 1000

  def solve do
    1..998
    |> Stream.flat_map(fn a ->
      Stream.map((a + 1)..999, fn b ->
        {a, b, @sum - a - b}
      end)
    end)
    |> Stream.filter(fn {_a, b, c} -> c > b end)
    |> Stream.filter(fn {a, b, c} -> a * a + b * b == c * c end)
    |> Enum.at(0)
    |> then(fn {a, b, c} -> a * b * c end)
  end
end
