defmodule PythagorasTail do
  @moduledoc "tail recursion solution"
  @sum 1000

  def solve do
    case search(1, 2) do
      {a, b, c} -> a * b * c
      nil -> nil
    end
  end

  defp search(a, _b) when a >= @sum - 2, do: nil
  defp search(a, b) when b >= @sum - a, do: search(a + 1, a + 2)
  defp search(a, b) do
    c = @sum - a - b
    if c <= b do
      search(a, b + 1)
    else
      if a * a + b * b == c * c do
        {a, b, c}
      else
        search(a, b + 1)
      end
    end
  end

  def triplet_product, do: solve()
end
