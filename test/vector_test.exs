defmodule VectorTest do
  use ExUnit.Case

  test "inner_product" do
    assert(Vector.inner_product([4, 7], [10, 1]) == 47)
  end

  test "magnitude" do
    assert(Vector.magnitude([5, 8, 2]) == 9.643650760992955)
  end

  test "div" do
    assert(Vector.div([1, 2, 3], 7) == [0.14285714285714285, 0.2857142857142857, 0.42857142857142855])
  end

  test "normalize" do
    normalized_vector = Vector.normalize([5,8,2])
    assert(normalized_vector == [0.5184758473652127, 0.8295613557843402, 0.20739033894608505])
    assert(Vector.magnitude(normalized_vector) == 1.0)
  end

  test "size" do
    assert(Vector.size([1]) == 1)
    assert(Vector.size([1, 2]) == 2)
    assert(Vector.size([1, 2, 3]) == 3)
    assert(Vector.size([1, 2, 3, 4]) == 4)
  end
end
