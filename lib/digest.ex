defmodule Digest do
  @author "Gregoire Lejeune <gregoire.lejeune@free.fr>"
  @moduledoc """
  This module provides a set of cryptographic functions.
  """

  defp hex(n) when n < 10 do
    48 + n
  end

  defp hex(n) when n >= 10 and n < 16 do
    97 + (n - 10)
  end

  defp list_to_hex(l) do
    Enum.map(l, fn(x) -> int_to_hex(x) end)
  end

  defp int_to_hex(i) when i < 256 do
    [hex(div(i, 16)), hex(rem(i, 16))]
  end

  @doc """
  Return the MD4 of the given string
  """
  def md4(s) do
    :crypto.hash(:md4, s) 
  end

  @doc """
  Return the MD5 of the given string
  """
  def md5(s) do
    :crypto.hash(:md5, s) 
  end

  @doc """
  Return the SHA1 of the given string
  """
  def sha1(s) do
    :crypto.hash(:sha, s)
  end

  @doc """
  Return the SHA224 of the given string
  """
  def sha224(s) do
    :crypto.hash(:sha224, s)
  end

  @doc """
  Return the SHA256 of the given string
  """
  def sha256(s) do
    :crypto.hash(:sha256, s)
  end

  @doc """
  Return the SHA384 of the given string
  """
  def sha384(s) do
    :crypto.hash(:sha384, s)
  end

  @doc """
  Return the SHA512 of the given string
  """
  def sha512(s) do
    :crypto.hash(:sha512, s)
  end

  @doc """
  Return the Ripem160 of the given string
  """
  def ripem160(s) do
    :crypto.hash(:ripem160, s)
  end

  @doc """
  Call the given hash function on the given string.

  `type` can be :

  * `:md4`
  * `:md5`
  * `:ripemd160`
  * `:sha`
  * `:sha224`
  * `:sha256`
  * `:sha384`
  * `:sha512`
  """
  def hash(type, data) do
    :crypto.hash(type, data)
  end

  @doc """
  Return the MD5 HMAC of the given key and string
  """
  def md4_hmac(k, s) do
    :crypto.hmac(:md4, k, s)
  end

  @doc """
  Return the MD5 HMAC of the given key and string
  """
  def md5_hmac(k, s) do
    :crypto.hmac(:md5, k, s)
  end

  @doc """
  Return the SHA1 HMAC of the given key and string
  """
  def sha1_hmac(k, s) do
    :crypto.hmac(:sha, k, s)
  end

  @doc """
  Return the SHA224 HMAC of the given key and string
  """
  def sha224_hmac(k, s) do
    :crypto.hmac(:sha224, k, s)
  end

  @doc """
  Return the SHA256 HMAC of the given key and string
  """
  def sha256_hmac(k, s) do
    :crypto.hmac(:sha256, k, s)
  end

  @doc """
  Return the SHA384 HMAC of the given key and string
  """
  def sha384_hmac(k, s) do
    :crypto.hmac(:sha384, k, s)
  end

  @doc """
  Return the SHA512 HMAC of the given key and string
  """
  def sha512_hmac(k, s) do
    :crypto.hmac(:sha512, k, s)
  end

  @doc """
  Return the HMAC for the given algorithm, key and value

  `type` can be :

  * `:md5`
  * `:sha`
  * `:sha224`
  * `:sha256`
  * `:sha384`
  * `:sha512`
  """
  def hmac(type, key, data) do
    :crypto.hmac(type, key, data)
  end

  @doc """
  Create a new HMAC context for the given algorithm and key

  `type` can be :

  * `:md5`
  * `:sha`
  * `:sha224`
  * `:sha256`
  * `:sha384`
  * `:sha512`
  """
  def hmac_init(type, key) do
    :crypto.hmac_init(type, key)
  end

  @doc """
  Update the given HMAC context with the given data
  """
  def hmac_update(context, data) do
    :crypto.hmac_update(context, data)
  end

  @doc """
  Finalize the given HMAC context and return the digest
  """
  def hmac_final(context) do
    :crypto.hmac_final(context)
  end

  @doc """
  Create a new hash context for the given algorithm

  `type` can be :

  * `:md4`
  * `:md5`
  * `:ripemd160`
  * `:sha`
  * `:sha224`
  * `:sha256`
  * `:sha384`
  * `:sha512`
  """
  def hash_init(type) do
    :crypto.hash_init(type)
  end

  @doc """
  Update the given hash context with the given data
  """
  def hash_update(context, data) do
    :crypto.hash_update(context, data)
  end

  @doc """
  Finalize the given hash context and return the digest
  """
  def hash_final(context) do
    :crypto.hash_final(context)
  end

  @doc """
  Generates n bytes randomly uniform 0..255
  """
  def rand_bytes(n) do
    :crypto.rand_bytes(n)
  end

  @doc """
  Generates a hex-encoded version of the given digest
  """
  def hexdigest(b) do
    md5_list = :binary.bin_to_list(b)
    List.flatten(list_to_hex(md5_list))
  end
end
