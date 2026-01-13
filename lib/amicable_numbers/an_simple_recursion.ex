defmodule AmicableRecursion do
  @moduledoc "simple recursion solution"
  def solve(limit \\ 10_000) do
    sum_amicable(1, limit)
  end

  defp sum_amicable(i, limit) when i >= limit, do: 0

  defp sum_amicable(i, limit) do
    res = sum_amicable(i + 1, limit)
    sum_n = sum_divisors(i)

    if sum_n > i and sum_n <= limit and sum_divisors(sum_n) == i do
      i + sum_n + res
    else
      res
    end
  end

  defp sum_divisors(1), do: 0

  defp sum_divisors(n) do
    calculate_divisors(2, :math.sqrt(n) |> trunc(), n)
  end

  defp calculate_divisors(i, limit, _n) when i > limit, do: 1

  defp calculate_divisors(i, limit, n) do
    res = calculate_divisors(i + 1, limit, n)

    if rem(n, i) == 0 do
      j = div(n, i)

      if i == j do
        res + i
      else
        res + i + j
      end
    else
      res
    end
  end
end
