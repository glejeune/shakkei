defmodule ExtUtils do
  def list_to_list_of_string(list) do
    Enum.map list, fn(x) -> [x] = :io_lib.format("~c", [x]); list_to_bitstring(x) end
  end

  def list_to_list_of_int(list) do
    Enum.map list, fn(x) -> [x] = :io_lib.format("~c", [x]); {x, _} = String.to_integer(list_to_bitstring(x)); x end
  end
end
