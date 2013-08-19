defmodule Math do
  @moduledoc """
  This module provides an interface to a number of mathematical functions.
  """

  def pi do
    :math.pi()
  end

  def sin(x), do: :math.sin(x)
  def cos(x), do: :math.cos(x)
  def tan(x), do: :math.tan(x)
  def asin(x), do: :math.asin(x)
  def acos(x), do: :math.acos(x)
  def atan(x), do: :math.atan(x)
  def atan2(x), do: :math.atan2(x)
  def sinh(x), do: :math.sinh(x)
  def cosh(x), do: :math.cosh(x)
  def tanh(x), do: :math.tanh(x)
  def asinh(x), do: :math.asinh(x)
  def acosh(x), do: :math.acosh(x)
  def atanh(x), do: :math.atanh(x)
  def exp(x), do: :math.exp(x)
  def log(x), do: :math.log(x)
  def log10(x), do: :math.log10(x)
  def pow(x, y), do: :math.pow(x, y)
  def sqrt(x), do: :math.sqrt(x)
  def erf(x), do: :math.erf(x)
  def erfc(x), do: :math.erfc(x)
end
