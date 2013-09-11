defmodule DataTest do
  use ExUnit.Case

  test "Data tests" do
    assert(Data.type(:atom) == :atom)
    assert(Data.type(<<1, 2, 3>>) == :binary)
    assert(Data.type("hello") == :binary)
    try do
      raise "exception"
    rescue 
      e -> assert(Data.type(e) == :exception)
    end
    assert(Data.type(1.2) == :float)
    assert(Data.type(123) == :integer)
    assert(Data.type([1, 2, 3]) == :list)
    assert(Data.type(1..2) == :range)
    assert(Data.type(%r/regex/) == :regex)
    assert(Data.type({:one, :two}) == :tuple)
    assert(Data.type(fn(x) -> x*x end) == :function)
  end
end
