defmodule ExtUtils do
  defexception ExtUtilsError, message: "unknown error", can_retry: false do
    def full_message(me) do
      "Tempfile failed: #{me.message}, retriable: #{me.can_retry}"
    end
  end

  def list_to_list_of_string(list) do
  Enum.map list, fn(x) -> [x] = :io_lib.format("~c", [x]); list_to_bitstring(x) end
end

  def list_to_list_of_int(list) do
  Enum.map list, fn(x) -> [x] = :io_lib.format("~c", [x]); {x, _} = String.to_integer(list_to_bitstring(x)); x end
  end

  defmodule ExEnum do
    def each2(v1, v2, f) when is_list(v1) and is_list(v2) do
      case length(v1) == length(v2) do
        false -> raise ExtUtilsError, message: "Lists must have the same size"
        true -> :ok
      end

      Enum.each Enum.zip(v1, v2), fn {x, y} -> f.(x, y) end
    end

    def reduce2(v1, v2, acc, f) when is_list(v1) and is_list(v2) do
      case length(v1) == length(v2) do
        false -> raise ExtUtilsError, message: "Lists must have the same size"
        true -> :ok
      end

      Enum.reduce Enum.zip(v1, v2), acc, fn({x, y}, acc) -> f.(x, y, acc) end
    end
  end
end
