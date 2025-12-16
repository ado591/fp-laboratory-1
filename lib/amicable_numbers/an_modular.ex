defmodule AmicableModular do
  @moduledoc "Modular Solution"

  defmodule Generator do
    @moduledoc "generator"
    def generate(limit), do: 1..limit
  end

  defmodule Filter do
    @moduledoc "filter"
    def filter(seq), do: Enum.filter(seq, &amicable?/1)

    defp amicable?(n) do
      b = sum_divs(n)
      b != n and sum_divs(b) == n
    end

    defp sum_divs(n) when n <= 1, do: 0

    defp sum_divs(n) do
      limit = :math.sqrt(n) |> trunc()
      1..limit
      |> Enum.reduce(0, fn d, acc ->
        with true <- rem(n, d) == 0,
             other <- div(n, d) do
          case {d, other} do
            {1, ^n} -> acc + 1
            {1, _} -> acc + 1 + other
            {^d, ^d} -> acc + d
            _ -> acc + d + other
          end
        else
          false -> acc
        end
      end)
    end
  end

  defmodule Reducer do
    @moduledoc "reducer"
    def reduce(seq), do: Enum.reduce(seq, 0, &+/2)
  end

  def solve(limit \\ 10_000) do
    limit
    |> Generator.generate()
    |> Filter.filter()
    |> Reducer.reduce()
  end
end
