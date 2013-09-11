defmodule Data do
  def type(data) do
    cond do
	    is_exception(data) -> :exception
	    is_regex(data) -> :regex
	    is_range(data) -> :range
	    is_tuple(data) -> :tuple
	    is_reference(data) -> :reference
	    is_pid(data) -> :pid
	    is_port(data) -> :port
      is_atom(data) -> :atom
	    is_binary(data) -> :binary
	    is_boolean(data) -> :boolean
	    is_float(data) -> :float
	    is_function(data) -> :function
	    is_integer(data) -> :integer
	    is_list(data) -> :list
	    is_number(data) -> :number
    end
  end
end
