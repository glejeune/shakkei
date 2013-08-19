defmodule ExtUtilsTest do
  use ExUnit.Case

  test "reduce2" do
    assert(ExtUtils.ExEnum.reduce2([1, 2, 3], [4, 5, 6], 0, &(&1 + &2 + &3)) == 5+7+9)
    assert(ExtUtils.ExEnum.reduce2([1, 2, 3], [4, 5, 6], [], &(&3 ++ [&1 + &2])) == [5, 7, 9])
  end
end
