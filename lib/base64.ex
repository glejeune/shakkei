defmodule Base64 do
  @doc """
  Return a Base64-encoded version of the given string or list, as list
  """
  def encode(bs) when is_bitstring(bs) do
    encode(bitstring_to_list(bs))
  end
  def encode(list) when is_list(list) do
    :base64.encode_to_string(list)
  end

  @doc """
  Return a Base64-encoded version of the given string or list, as string
  """
  def encode_to_string(bs) when is_bitstring(bs) do
    encode_to_string(bitstring_to_list(bs))
  end
  def encode_to_string(list) when is_list(list) do
    :base64.encode(list)
  end

  @doc """
  Return a Base64-decoded version of the given string or list, as list
  """
  def decode(bs) when is_bitstring(bs) do
    decode(bitstring_to_list(bs))
  end
  def decode(list) when is_list(list) do
    :base64.decode_to_string(list)
  end

  @doc """
  Return a Base64-decoded version of the given string or list, as string
  """
  def decode_to_string(bs) when is_bitstring(bs) do
    decode_to_string(bitstring_to_list(bs))
  end
  def decode_to_string(list) when is_list(list) do
    :base64.decode(list)
  end
end
