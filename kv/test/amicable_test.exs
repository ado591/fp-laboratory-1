defmodule AmicableTest do
  use ExUnit.Case

  @answer 31_626  # руками посчитали

  test "tail recursive version works" do
    assert AmicableTail.solve() == @answer
  end

  test "non-tail recursive version works" do
    assert AmicableRecursion .solve() == @answer
  end

  test "modular version works" do
    assert AmicableModular.solve() == @answer
  end

  test "stream version works" do
    assert AmicableStream.solve() == @answer
  end

  test "returns integer" do
    assert is_integer(AmicableTail.solve())
  end
end
