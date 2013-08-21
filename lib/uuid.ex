defmodule UUID do
  # from http://www.asergienko.com/erlang-how-to-create-uuid-or-session-id/
  def generate do
    now = {_, _, micro} = :erlang.now()
    nowish = :calendar.now_to_universal_time(now)
    nowsecs = :calendar.datetime_to_gregorian_seconds(nowish)
    then = :calendar.datetime_to_gregorian_seconds({{1970, 1, 1}, {0, 0, 0}})
    prefix = :io_lib.format("~14.16.0b", [(nowsecs - then) * 1000000 + micro])
    :erlang.list_to_binary(prefix ++ to_hex(:crypto.rand_bytes(9)))
  end

  defp to_hex([]), do: []
  defp to_hex(bin) when is_binary(bin), do: to_hex(:erlang.binary_to_list(bin))
  defp to_hex([h|t]), do: [to_digit(div(h, 16)), to_digit(rem(h, 16)) | to_hex(t)]
  defp to_digit(n) when n < 10, do: ?0 + n
  defp to_digit(n), do: ?a + n - 10
end
