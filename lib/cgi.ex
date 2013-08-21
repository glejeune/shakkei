defmodule CGI do
  use Bitwise
  # Taken from <http://erlangexamples.com/>,
  # from <http://github.com/CapnKernul/httparadise>
  # and <http://www.erlang.org/doc/man/edoc_lib.html>
  # and <https://gist.github.com/renatoalbano/3796470>

  @doc """
  URL-encode a string, according to the RFC3986
  """
  def encode([c|cs]) when c >= ?a and c <= ?z do
    [c|encode(cs)]
  end
  def encode([c|cs]) when c >= ?A and c <= ?Z do
    [c|encode(cs)]
  end
  def encode([c|cs]) when c >= ?0 and c <= ?9 do
    [c|encode(cs)]
  end
  def encode([c = ?- | cs]) do
    [c | encode(cs)]
  end
  def encode([c = ?_ | cs]) do
    [c | encode(cs)]
  end
  def encode([c = 46 | cs]) do # .
    [c | encode(cs)]
  end
  def encode([c = ?~ | cs]) do # .
    [c | encode(cs)]
  end
  def encode([c | cs]) when c <= 127 do
    encode_byte(c) ++ encode(cs)
  end
  def encode([c | cs]) when c >= 127 and c <= 2047 do
    encode_byte(bsr(c, 6) + 192)
    ++ encode_byte(band(c, 63) + 128)
    ++ encode(cs)
  end
  def encode([c | cs]) when c > 2047 do
    encode_byte(bsr(c, 12) + 224)
    ++ encode_byte(band(63, bsr(c, 6)) + 128)
    ++ encode_byte(band(c, 63) + 128)
    ++ encode(cs)
  end
  def encode([c | cs]) do
    encode_byte(c) ++ encode(cs)
  end
  def encode([]), do: []

  # from edoc_lib source
  defp hex_octet(n) when n <= 9, do: [?0 + n]
  defp hex_octet(n) when n > 15, do: hex_octet(bsr(n, 4)) ++ hex_octet(band(n, 15))
  defp hex_octet(n), do: [n - 10 + ?a]

  defp encode_byte(c), do: normalize(hex_octet(c))

  ## Append 0 if length == 1
  defp normalize(h) when length(h) == 1, do: '%0' ++ h
  defp normalize(h), do: '%' ++ bitstring_to_list(String.upcase(list_to_bitstring(h)))
end
