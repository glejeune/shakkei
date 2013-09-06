defmodule Data do
	def type(data) when is_atom(data), do: :atom
	def type(data) when is_binary(data), do: :binary
	def type(data) when is_bitstring(data), do: :bitstring
	def type(data) when is_boolean(data), do: :boolean
	def type(data) when is_exception(data), do: :exception
	def type(data) when is_float(data), do: :float
	def type(data) when is_function(data), do: :function
	def type(data) when is_integer(data), do: :integer
	def type(data) when is_list(data), do: :list
	def type(data) when is_number(data), do: :number
	def type(data) when is_pid(data), do: :pid
	def type(data) when is_port(data), do: :port
	def type(data) when is_range(data), do: :range
	def type(data) when is_record(data), do: :record
	def type(data) when is_reference(data), do: :reference
	def type(data) when is_regex(data), do: :regex
	def type(data) when is_tuple(data), do: :tuple
end