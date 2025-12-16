defmodule AmicableStream do
  @moduledoc "stream solution"
  def solve(limit \\ 10_000) do
    1..limit
    |> Enum.map(fn n -> {n, amicable?(n, limit)} end)
    |> Enum.filter(fn {_n, flag} -> flag end)
    |> Enum.map(fn {n, _} -> n end)
    |> Enum.sum()
  end

  defp amicable?(n, limit) do
    b = sum_divs(n)
    b != n and b != 0 and b <= limit and sum_divs(b) == n
  end

  defp sum_divs(0), do: 0
  defp sum_divs(1), do: 0
  defp sum_divs(n) when n < 0, do: 0

  defp sum_divs(n) do
    limit = :math.sqrt(n) |> trunc()

    1..limit
    |> Enum.reduce(0, fn d, acc ->
      divisible? = rem(n, d) == 0
      add_to_sum = divisible? and divisor_sum_contribution(d, n)
      if divisible?, do: acc + add_to_sum, else: acc
    end)
  end

  defp divisor_sum_contribution(d, n) do
    other = div(n, d)
    case {d, other} do
      {1, ^n} -> 1
      {1, other} -> 1 + other
      {d, ^d} -> d
      {d, other} -> d + other
    end
  end
end
