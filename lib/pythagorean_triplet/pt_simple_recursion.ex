defmodule PythagorasRec do
  @moduledoc "simple recursion solution"
  @sum 1000

  def solve do
    case find_triplet(1) do
      {a, b, c} -> a * b * c
      nil -> nil
    end
  end

  def triplet_product, do: solve()

  defp find_triplet(a) when a >= @sum - 2, do: nil

  defp find_triplet(a) do
    case find_for_a(a, a + 1) do
      nil ->
        triplet = find_triplet(a + 1)
        if triplet, do: triplet, else: nil

      triplet ->
        triplet
    end
  end

  defp find_for_a(_a, b) when b >= @sum, do: nil

  defp find_for_a(a, b) do
    c = @sum - a - b

    cond do
      c <= b ->
        find_for_a(a, b + 1)

      a * a + b * b == c * c ->
        {a, b, c}

      true ->
        find_for_a(a, b + 1)
    end
  end
end
