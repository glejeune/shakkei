defmodule Convert do
  @moduledoc """
  This module offer helpers to convert Decimal <> Hexa <> Binary <> Octal
  """

  defmodule Decimal do
    import ExtUtils

    @moduledoc """
    This module allow you to convert decimal to hexa, binary and octal
    """

    @doc """
    Convert the given decimal value to a list of it's hexadecimal representation

    ## Example

        iex> Convert.Decimal.to_hex_list(160)
        'A0'
    """
    def to_hex_list(value) do
      integer_to_list(value, 16)
    end

    @doc """
    Convert the given decimal value to a list of strings of it's hexadecimal representation

    ## Example

        iex> Convert.Decimal.to_hex_list_string(160)
        ["A", "0"]
    """
    def to_hex_list_string(value) do
      list_to_list_of_string(to_hex_list(value))
    end

    @doc """
    Convert the given decimal value to a string of it's hexadecimal representation

    ## Example

        iex> Convert.Decimal.to_hex_string(160)
        "A0"
    """
    def to_hex_string(value) do
      to_hex_list(value) |> list_to_bitstring
    end

    @doc """
    Convert the given decimal value to a list of it's binary representation

    ## Example

        iex> Convert.Decimal.to_binary_list(160)
        '10100000'
    """
    def to_binary_list(value) do
      integer_to_list(value, 2)
    end

    @doc """
    Convert the given decimal value to list of integers of it's binary representation

    ## Example

        iex> Convert.Decimal.to_binary_list_integer(160)
        [1, 0, 1, 0, 0, 0, 0, 0]
    """
    def to_binary_list_integer(value) do
      list_to_list_of_int(to_binary_list(value))
    end

    @doc """
    Convert the given decimal value to a string of it's binary representation

    ## Example

        iex> Convert.Decimal.to_binary_string(160)
        "10100000"
    """
    def to_binary_string(value) do
      to_binary_list(value) |> list_to_bitstring
    end

    @doc """
    Convert the given decimal value to a list of it's octal representation

    ## Example

        iex> Convert.Decimal.to_octal_list(160)
        '240'
    """
    def to_octal_list(value) do
      integer_to_list(value, 8)
    end

    @doc """
    Convert the given decimal value to a list of integers of it's octal representation

    ## Example

        iex> Convert.Decimal.to_octal_list_integer(160)
        [2, 4, 0]
    """
    def to_octal_list_integer(value) do
      to_octal_list(value) |> list_to_list_of_int
    end

    @doc """
    Convert the given decimal value to a string of it's octal representation

    ## Example

        iex> Convert.Decimal.to_octal_string(160)
        "240"
    """
    def to_octal_string(value) do
      to_octal_list(value) |> list_to_bitstring
    end

    @doc """
    Convert the given decimal value to an integer of it's octal representation

    ## Example

        iex> Convert.Decimal.to_octal_integer(160)
        240
    """
    def to_octal_integer(value) do
      to_octal_list(value) |> list_to_integer
    end
  end

  defmodule Hexadecimal do
    @doc """
    Convert the given hexadecimal value to it's decimal representation

    ## Example

        iex> Convert.Hexadecimal.to_decimal("A0")
        160
        iex> Convert.Hexadecimal.to_decimal('A0')
        160
        iex> Convert.Hexadecimal.to_decimal(["A", "0"])
        160
    """
    def to_decimal(value) when is_bitstring(value) do
      to_decimal(bitstring_to_list(value))
    end
    def to_decimal(value) when is_list(value) do
      list_str = Enum.take_while(value, fn(x) -> is_bitstring(x) end)
      if length(value) == length(list_str) do
        to_decimal(Enum.join(value))
      else
        list_to_integer(value, 16)
      end
    end

    @doc """
    Convert the given hexadecimal value to a list of it's binary representation

    ## Example

        iex> Convert.Hexadecimal.to_binary_list("A0")
        '10100000'
        iex> Convert.Hexadecimal.to_binary_list('A0')
        '10100000'
        iex> Convert.Hexadecimal.to_binary_list(["A", "0"]) 
        '10100000'
    """
    def to_binary_list(value) do  
      Convert.Decimal.to_binary_list(to_decimal(value))
    end
    
    @doc """
    Convert the given hexadecimal value to a list of integer to it's binary representation

    ## Example

        iex> Convert.Hexadecimal.to_binary_list_integer("A0")
        [1, 0, 1, 0, 0, 0, 0, 0]
        iex> Convert.Hexadecimal.to_binary_list_integer('A0')
        [1, 0, 1, 0, 0, 0, 0, 0]
        iex> Convert.Hexadecimal.to_binary_list_integer(["A", "0"]) 
        [1, 0, 1, 0, 0, 0, 0, 0]
    """
    def to_binary_list_integer(value) do  
      Convert.Decimal.to_binary_list_integer(to_decimal(value))
    end

    @doc """
    Convert the given hexadecimal value to a string of it's binary representation

    ## Example

        iex> Convert.Hexadecimal.to_binary_string("A0")
        "10100000"
        iex> Convert.Hexadecimal.to_binary_string('A0')
        "10100000"
        iex> Convert.Hexadecimal.to_binary_string(["A", "0"]) 
        "10100000"
    """
    def to_binary_string(value) do
      Convert.Decimal.to_binary_string(to_decimal(value))
    end

    @doc """
    Convert the given hexadecimal value to an integer of it's octal representation

    ## Example

        iex> Convert.Hexadecimal.to_octal_integer("A0")
        240
        iex> Convert.Hexadecimal.to_octal_integer('A0')
        240
        iex> Convert.Hexadecimal.to_octal_integer(["A", "0"])
        240
    """
    def to_octal_integer(value) do  
      Convert.Decimal.to_octal_integer(to_decimal(value))
    end

    @doc """
    Convert the given hexadecimal value to a list of it's octal representation

    ## Example

        iex> Convert.Hexadecimal.to_octal_list("A0")
        '240'
        iex> Convert.Hexadecimal.to_octal_list('A0')
        '240'
        iex> Convert.Hexadecimal.to_octal_list(["A", "0"])
        '240'
    """
    def to_octal_list(value) do
      Convert.Decimal.to_octal_list(to_decimal(value))
    end
    
    @doc """
    Convert the given hexadecimal value to a list of integers of it's octal representation

    ## Example

        iex> Convert.Hexadecimal.to_octal_list_integer("A0")
        [2, 4, 0]
        iex> Convert.Hexadecimal.to_octal_list_integer('A0')
        [2, 4, 0]
        iex> Convert.Hexadecimal.to_octal_list_integer(["A", "0"])
        [2, 4, 0]
    """
    def to_octal_list_integer(value) do  
      Convert.Decimal.to_octal_list_integer(to_decimal(value))
    end
    
    @doc """
    Convert the given hexadecimal value to a string of it's octal representation

    ## Example

        iex> Convert.Hexadecimal.to_octal_string("A0")
        "240"
        iex> Convert.Hexadecimal.to_octal_string('A0')
        "240"
        iex> Convert.Hexadecimal.to_octal_string(["A", "0"])
        "240"
    """
    def to_octal_string(value) do
      Convert.Decimal.to_octal_string(to_decimal(value))
    end
  end

  defmodule Binary do
    @doc """
    Convert the given binary value to it's decimal representation

    ## Example

        iex> Convert.Binary.to_decimal("10100000")
        160
        iex> Convert.Binary.to_decimal('10100000')
        160
        iex> Convert.Binary.to_decimal([1,0,1,0,0,0,0,0])
        160
    """
    def to_decimal(value) when is_bitstring(value) do
      to_decimal(bitstring_to_list(value))
    end
    def to_decimal(value) when is_list(value) do
      list_int = Enum.take_while(value, fn(x) -> x in [0, 1] end)
      if length(value) == length(list_int) do
        to_decimal(List.foldl value, "", fn(x, acc) -> acc <> Macro.to_string(x) end)
      else
        list_to_integer(value, 2)
      end
    end

    @doc """
    Convert the given binary value to a list of it's hexadecimal representation

    ## Example

        iex> Convert.Binary.to_hex_list("10100000")
        'A0'
        iex> Convert.Binary.to_hex_list('10100000')
        'A0'
        iex> Convert.Binary.to_hex_list([1,0,1,0,0,0,0,0])
        'A0'
    """
    def to_hex_list(value) do  
      Convert.Decimal.to_hex_list(to_decimal(value))
    end
    
    @doc """
    Convert the given binary value to a lits of strings of it's hexadecimal representation

    ## Example

        iex> Convert.Binary.to_hex_list_string("10100000")
        ["A", "0"]
        iex> Convert.Binary.to_hex_list_string('10100000')
        ["A", "0"]
        iex> Convert.Binary.to_hex_list_string([1,0,1,0,0,0,0,0])
        ["A", "0"]
    """
    def to_hex_list_string(value) do  
      Convert.Decimal.to_hex_list_string(to_decimal(value))
    end
    
    @doc """
    Convert the given binary value to a string of it's hexadecimal representation

    ## Example

        iex> Convert.Binary.to_hex_string("10100000")
        "A0"
        iex> Convert.Binary.to_hex_string('10100000')
        "A0"
        iex> Convert.Binary.to_hex_string([1,0,1,0,0,0,0,0])
        "A0"
    """
    def to_hex_string(value) do
      Convert.Decimal.to_hex_string(to_decimal(value))
    end
    
    @doc """
    Convert the given binary value to an integer of it's octal representation

    ## Example

        iex> Convert.Binary.to_octal_integer("10100000")
        240
        iex> Convert.Binary.to_octal_integer('10100000')
        240
        iex> Convert.Binary.to_octal_integer([1,0,1,0,0,0,0,0])
        240
    """
    def to_octal_integer(value) do  
      Convert.Decimal.to_octal_integer(to_decimal(value))
    end
    
    @doc """
    Convert the given binary value to a list of it's octal representation

    ## Example

        iex> Convert.Binary.to_octal_list("10100000")
        '240'
        iex> Convert.Binary.to_octal_list('10100000')
        '240'
        iex> Convert.Binary.to_octal_list([1,0,1,0,0,0,0,0])
        '240'
    """
    def to_octal_list(value) do
      Convert.Decimal.to_octal_list(to_decimal(value))
    end
    
    @doc """
    Convert the given binary value to a list of integers of it's octal representation

    ## Example

        iex> Convert.Binary.to_octal_list_integer("10100000")
        [2, 4, 0]
        iex> Convert.Binary.to_octal_list_integer('10100000')
        [2, 4, 0]
        iex> Convert.Binary.to_octal_list_integer([1,0,1,0,0,0,0,0])
        [2, 4, 0]
    """
    def to_octal_list_integer(value) do  
      Convert.Decimal.to_octal_list_integer(to_decimal(value))
    end
    
    @doc """
    Convert the given binary value to a string of it's octal representation

    ## Example

        iex> Convert.Binary.to_octal_string("10100000")
        "240"
        iex> Convert.Binary.to_octal_string('10100000')
        "240"
        iex> Convert.Binary.to_octal_string([1,0,1,0,0,0,0,0])
        "240"
    """
    def to_octal_string(value) do
      Convert.Decimal.to_octal_string(to_decimal(value))
    end
  end

  defmodule Octal do
    @doc """
    Convert the given octal value to an integer of it's decial representation

    ## Example

        iex> Convert.Octal.to_decimal(240)
        160
        iex> Convert.Octal.to_decimal("240")
        160
        iex> Convert.Octal.to_decimal('240')
        160
        iex> Convert.Octal.to_decimal([2, 4, 0])
        160
    """
    def to_decimal(value) when is_integer(value) do
      to_decimal(Macro.to_string(value))
    end
    def to_decimal(value) when is_bitstring(value) do
      to_decimal(bitstring_to_list(value))
    end
    def to_decimal(value) when is_list(value) do
      list_int = Enum.take_while(value, fn(x) -> x in (Enum.map 0..9, &(&1)) end)
      if length(list_int) == length(value) do
        to_decimal(List.foldl value, "", fn(x, acc) -> acc <> Macro.to_string(x) end)
      else
        list_to_integer(value, 8)
      end
    end

    @doc """
    Convert the given octal value to a list of it's binary representation

    ## Example

        iex> Convert.Octal.to_binary_list(240)
        '10100000'
        iex> Convert.Octal.to_binary_list("240")
        '10100000'
        iex> Convert.Octal.to_binary_list('240')
        '10100000'
        iex> Convert.Octal.to_binary_list([2, 4, 0])
        '10100000'
    """
    def to_binary_list(value) do  
      Convert.Decimal.to_binary_list(to_decimal(value))
    end
    @doc """
    Convert the given octal value to a list of integers of it's binary representation

    ## Example

        iex> Convert.Octal.to_binary_list_integer(240)
        [1,0,1,0,0,0,0,0]
        iex> Convert.Octal.to_binary_list_integer("240")
        [1,0,1,0,0,0,0,0]
        iex> Convert.Octal.to_binary_list_integer('240')
        [1,0,1,0,0,0,0,0]
        iex> Convert.Octal.to_binary_list_integer([2, 4, 0])
        [1,0,1,0,0,0,0,0]
    """
    def to_binary_list_integer(value) do  
      Convert.Decimal.to_binary_list_integer(to_decimal(value))
    end
    @doc """
    Convert the given octal value to a string of it's binary representation

    ## Example

        iex> Convert.Octal.to_binary_string(240)
        "10100000"
        iex> Convert.Octal.to_binary_string("240")
        "10100000"
        iex> Convert.Octal.to_binary_string('240')
        "10100000"
        iex> Convert.Octal.to_binary_string([2, 4, 0])
        "10100000"
    """
    def to_binary_string(value) do
      Convert.Decimal.to_binary_string(to_decimal(value))
    end
    @doc """
    Convert the given octal value to a list of it's hexadecimal representation

    ## Example

        iex> Convert.Octal.to_hex_list(240)
        'A0'
        iex> Convert.Octal.to_hex_list("240")
        'A0'
        iex> Convert.Octal.to_hex_list('240')
        'A0'
        iex> Convert.Octal.to_hex_list([2, 4, 0])
        'A0'
    """
    def to_hex_list(value) do  
      Convert.Decimal.to_hex_list(to_decimal(value))
    end
    @doc """
    Convert the given octal value to a list of strings og it's hexadecimal representation

    ## Example

        iex> Convert.Octal.to_hex_list_string(240)
        ["A", "0"]
        iex> Convert.Octal.to_hex_list_string("240")
        ["A", "0"]
        iex> Convert.Octal.to_hex_list_string('240')
        ["A", "0"]
        iex> Convert.Octal.to_hex_list_string([2, 4, 0])
        ["A", "0"]
    """
    def to_hex_list_string(value) do  
      Convert.Decimal.to_hex_list_string(to_decimal(value))
    end

    @doc """
    Convert the given octal value to a string og it's hexadecimal representation

    ## Example

        iex> Convert.Octal.to_hex_string(240)
        "A0"
        iex> Convert.Octal.to_hex_string("240")
        "A0"
        iex> Convert.Octal.to_hex_string('240')
        "A0"
        iex> Convert.Octal.to_hex_string([2, 4, 0])
        "A0"
    """
    def to_hex_string(value) do
      Convert.Decimal.to_hex_string(to_decimal(value))
    end
  end
end


