defmodule InflectorTest do
  use ExUnit.Case

  test "camelize" do
    assert("HelloBeautiful.World" == Inflector.camelize("hello_beautiful/world"))
    assert("helloBeautiful.World" == Inflector.camelize("hello_beautiful/world", false))
  end

  test "underscore" do
    assert(Inflector.underscore("HelloBeautiful.World") == "hello_beautiful/world")
  end

  test "dasherize" do
    assert("bonjour-le-monde" == Inflector.dasherize("bonjour_le-monde"))
  end
end
