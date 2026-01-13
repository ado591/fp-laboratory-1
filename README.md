## Образцова Анжела Дмитриевна P3322 
### Вариант 9,21

### Problem 9. Special Pythagorean Triplet
A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

a^2+b^2 = c^2

For example, 3^2+4^2 = 25

There exists exactly one Pythagorean triplet for which a + b + c = 1000.

Find the product.

Кратко: надо найти произведение пифагоровой тройки, которая в сумме даст 1000. Гарантируется, что такая тройка существует и единственная

1. Не хвостовая рекурсия

```
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
```
2. Хвостовая рекурсия

```
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
```
3. Модульная реализация
```
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
```
4. Реализация через stream
```
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
```
5. Реализация на Typescript:
```
function findPythagoreanTriplet(sum: number): number {
    for (let a = 1; a < sum; a++) {
        for (let b = a + 1; b < sum; b++) {
            const c = sum - a - b;
            if (c > 0 && a * a + b * b === c * c) {
                return a * b * c;
            }
        }
    }
    return -1;
}
```

### Problem 21 Amicable Numbers

Для n обозначим за d(n) сумму его собственных делителей. a и b **amicable**, если 1) d(a) = b; 2) d(b) = a; 3) a != b
Нужно найти сумму всех дружественных чисел меньших 10.000

Также как и для задачи #9 было 4 решения на Elixir + реализация на Typescript
1. simple recursion
```
   defp sum_amicable(i, limit) do
    res = sum_amicable(i + 1, limit)
    sum_n = sum_divisors(i)

    if sum_n > i and sum_n <= limit and sum_divisors(sum_n) == i do
      i + sum_n + res
    else
      res
    end
  end
```
2. tail recuirsion
```
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
```
3. Модульное решение
```
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
```
4. Streams
```
  def solve(limit \\ 10_000) do
    1..limit
    |> Enum.map(fn n -> {n, amicable?(n, limit)} end)
    |> Enum.filter(fn {_n, flag} -> flag end)
    |> Enum.map(fn {n, _} -> n end)
    |> Enum.sum()
  end
```
6. Typescript
```
function sumDivisors(n: number): number {
    let sum = 0;
    for (let i = 1; i <= Math.sqrt(n); i++) {
        if (n % i === 0) {
            sum += i;
            if (i !== 1 && i !== n / i) {
                sum += n / i;
            }
        }
    }
    return sum;
}

function isAmicable(n: number): boolean {
    const b = sumDivisors(n);
    return b !== n && sumDivisors(b) === n;
}

function amicableNumbersSum(limit: number): number {
    let sum = 0;
    for (let i = 2; i < limit; i++) {
        if (isAmicable(i)) {
            sum += i;
        }
    }
    return sum;
}
```

### Выводы
В рамках лабораторной работы удалось решить задачу различными способами. Модульное решение и Streams оказались наиболее читаемыми и достаточно просты для расширения. Реализация без хвостовой рекурсии была достаточно неудобной для написания(так как задачи интуитивно хочется решить рекурсивно, но через хвостовую рекурсию). Обойти это ограничение через res + 0 невозможно, тк +0 и *1 оптимизируются компилятором. При этом не хвостовое решение может привести к переполнению стека. 
