defmodule PythagorasModular do
  @moduledoc "modular solution"
  defmodule Generator do
    @moduledoc "generator"
    @sum 1000
    def generate do
      for a <- 1..998,
          b <- (a + 1)..999,
          do: {a, b, @sum - a - b}
    end
  end

  defmodule Mapper do
    @moduledoc "mapper"
    def map(sequence), do: Enum.map(sequence, & &1)
  end

  defmodule Filter do
    @moduledoc "filter"
    def filter(sequence) do
      Enum.filter(sequence, fn {a, b, c} ->
        c > b and a * a + b * b == c * c
      end)
    end
  end

  defmodule Reducer do
    @moduledoc "reducer"
    def reduce([{a, b, c} | _]), do: a * b * c
  end

  def solve do
    Generator.generate()
    |> Mapper.map()
    |> Filter.filter()
    |> Reducer.reduce()
  end
end
