defmodule CGITest do
  use ExUnit.Case

  test "encode" do
    assert(CGI.encode('&') == '%26')
    assert(CGI.encode('é') == '%C3%A9')
    assert(CGI.encode(' ') == '%20')
    assert(CGI.encode('-') == '-')
    assert(CGI.encode('_') == '_')
    assert(CGI.encode('.') == '.')
    assert(CGI.encode('!') == '%21')
    assert(CGI.encode('*') == '%2A')
    assert(CGI.encode('~') == '~')
    assert(CGI.encode('\'') == '%27')
    assert(CGI.encode('"Hello World!"') == '%22Hello%20World%21%22')
  end
end
