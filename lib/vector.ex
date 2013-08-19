defmodule Vector do
  def inner_product(v1, v2) do
    ExtUtils.ExEnum.reduce2(v1, v2, 0, &(&3 + (&1 * &2)))
  end

  def magnitude(v) do
    Enum.reduce(v, 0, &(&2 + (&1 * &1))) |> Math.sqrt
  end

  def div(v, n) do
    Enum.reduce(v, [], &(&2 ++ [&1 / n]))
  end

  def normalize(v) do
    Vector.div(v, Vector.magnitude(v))
  end

  def size(v) do
    length(v)
  end
end
