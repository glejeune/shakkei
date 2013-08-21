defmodule Base64Test do
  use ExUnit.Case

  test "encode" do
    assert(Base64.encode('"Hello World!"') == 'IkhlbGxvIFdvcmxkISI=')
    assert(Base64.encode("\"Hello World!\"") == 'IkhlbGxvIFdvcmxkISI=')
  end

  test "encode_to_string" do
    assert(Base64.encode_to_string('"Hello World!"') == "IkhlbGxvIFdvcmxkISI=")
    assert(Base64.encode_to_string("\"Hello World!\"") == "IkhlbGxvIFdvcmxkISI=")
  end

  test "decode" do
    assert(Base64.decode('IkhlbGxvIFdvcmxkISI=') == '"Hello World!"')
    assert(Base64.decode("IkhlbGxvIFdvcmxkISI=") == '"Hello World!"')
  end

  test "decode_to_string" do
    assert(Base64.decode_to_string('IkhlbGxvIFdvcmxkISI=') == "\"Hello World!\"")
    assert(Base64.decode_to_string("IkhlbGxvIFdvcmxkISI=") == "\"Hello World!\"")
  end
end
