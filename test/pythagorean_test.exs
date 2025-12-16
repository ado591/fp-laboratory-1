defmodule PythagoreanTripletTest do
  use ExUnit.Case

  @answer 31_875_000

  test "tail recursive version works" do
    product = PythagorasTail.solve()
    assert product == @answer
  end

  test "non-tail recursive version works" do
    product = PythagorasRec.solve()
    assert product == @answer
  end

  test "modular version works" do
    product = PythagorasModular.solve()
    assert product == @answer
  end

  test "map version works" do
    product = PythagorasStream.solve()
    assert product == @answer
  end

  test "returns integer" do
    product = PythagorasTail.solve()
    assert is_integer(product)
  end
end
