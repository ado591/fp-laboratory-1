defmodule AmicableTail do
  @moduledoc "tail recursion solution"
  def solve(limit \\ 10_000), do: loop(1, limit, 0)

  defp loop(i, limit, acc) when i > limit, do: acc

  defp loop(i, limit, acc) do
    b = sum_of_divs(i)

    new_acc =
      if b > i and b <= limit and sum_of_divs(b) == i do
        acc + i + b
      else
        acc
      end

    loop(i + 1, limit, new_acc)
  end

  defp sum_of_divs(0), do: 0
  defp sum_of_divs(1), do: 0

  defp sum_of_divs(n) do
    divs_rec(2, :math.sqrt(n) |> trunc(), n, 1)
  end

  defp divs_rec(i, max, _n, acc) when i > max, do: acc

  defp divs_rec(i, max, n, acc) do
    acc2 =
      if rem(n, i) == 0 do
        other = div(n, i)

        if i == other do
          acc + i
        else
          acc + i + other
        end
      else
        acc
      end

    divs_rec(i + 1, max, n, acc2)
  end
end
