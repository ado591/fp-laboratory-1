defmodule AmicableRecursion do
  @moduledoc "simple recursion solution"
  def solve(limit \\ 10_000) do
    sum_amicable(1, limit)
  end

  defp sum_amicable(i, limit) when i >= limit, do: 0
  defp sum_amicable(i, limit) do
    sum_n = sum_divisors(i)
    if sum_n > i and sum_n <= limit and sum_divisors(sum_n) == i do
      i + sum_n + sum_amicable(i + 1, limit)
    else
      sum_amicable(i + 1, limit)
    end
  end

  defp sum_divisors(1), do: 0
  defp sum_divisors(n) do
    calculate_divisors(2, :math.sqrt(n) |> trunc(), n, 1)
  end

  defp calculate_divisors(i, limit, _n, acc) when i > limit, do: acc
  defp calculate_divisors(i, limit, n, acc) do
    if rem(n, i) == 0 do
      j = div(n, i)
      if i == j do
        calculate_divisors(i + 1, limit, n, acc + i)
      else
        calculate_divisors(i + 1, limit, n, acc + i + j)
      end
    else
      calculate_divisors(i + 1, limit, n, acc)
    end
  end
end
