defmodule ConvertTest do
  use ExUnit.Case

  test "Decimal to Hexadecimal list" do
    assert(Convert.Decimal.to_hex_list(160) == 'A0')
  end

  test "Decimal to Hexadecimal list string" do
    assert(Convert.Decimal.to_hex_list_string(160) == ["A", "0"])
  end

  test "Decimal to Hexadecimal string" do
    assert(Convert.Decimal.to_hex_string(160) == "A0")
  end

  test "Decimal to Binary list" do
    assert(Convert.Decimal.to_binary_list(160) == '10100000')
  end

  test "Decimal to Binary list integer" do
    assert(Convert.Decimal.to_binary_list_integer(160) == [1,0,1,0,0,0,0,0])
  end

  test "Decimal to Binary string" do
    assert(Convert.Decimal.to_binary_string(160) == "10100000")
  end

  test "Decimal to Octal list" do
    assert(Convert.Decimal.to_octal_list(160) == '240')
  end

  test "Decimal to Octal list integer" do
    assert(Convert.Decimal.to_octal_list_integer(160) == [2, 4, 0])
  end

  test "Decimal to Octal string" do
    assert(Convert.Decimal.to_octal_string(160) == "240")
  end

  test "Decimal to Octal integer" do
    assert(Convert.Decimal.to_octal_integer(160) == 240)
  end

  test "Binary to Decimal" do
    assert(Convert.Binary.to_decimal("10100000") == 160)
    assert(Convert.Binary.to_decimal('10100000') == 160)
    assert(Convert.Binary.to_decimal([1,0,1,0,0,0,0,0]) == 160)
  end

  test "Binary to Hexadecimal list" do
    assert(Convert.Binary.to_hex_list("10100000") == 'A0')
    assert(Convert.Binary.to_hex_list('10100000') == 'A0')
    assert(Convert.Binary.to_hex_list([1,0,1,0,0,0,0,0]) == 'A0')
  end

  test "Binary to Hexadecimal string list" do
    assert(Convert.Binary.to_hex_list_string("10100000") == ["A", "0"])
    assert(Convert.Binary.to_hex_list_string('10100000') == ["A", "0"])
    assert(Convert.Binary.to_hex_list_string([1,0,1,0,0,0,0,0]) == ["A", "0"])
  end

  test "Binary to Hexadecimal string" do
    assert(Convert.Binary.to_hex_string("10100000") == "A0")
    assert(Convert.Binary.to_hex_string('10100000') == "A0")
    assert(Convert.Binary.to_hex_string([1,0,1,0,0,0,0,0]) == "A0")
  end

  test "Binary to Octal integer" do
    assert(Convert.Binary.to_octal_integer("10100000") == 240)
    assert(Convert.Binary.to_octal_integer('10100000') == 240)
    assert(Convert.Binary.to_octal_integer([1,0,1,0,0,0,0,0]) == 240)
  end

  test "Binary to Octal list" do
    assert(Convert.Binary.to_octal_list("10100000") == '240')
    assert(Convert.Binary.to_octal_list('10100000') == '240')
    assert(Convert.Binary.to_octal_list([1,0,1,0,0,0,0,0]) == '240')
  end

  test "Binary to Octal list integer" do
    assert(Convert.Binary.to_octal_list_integer("10100000") == [2, 4, 0])
    assert(Convert.Binary.to_octal_list_integer('10100000') == [2, 4, 0])
    assert(Convert.Binary.to_octal_list_integer([1,0,1,0,0,0,0,0]) == [2, 4, 0])
  end

  test "Binary to Octal string" do
    assert(Convert.Binary.to_octal_string("10100000") == "240")
    assert(Convert.Binary.to_octal_string('10100000') == "240")
    assert(Convert.Binary.to_octal_string([1,0,1,0,0,0,0,0]) == "240")
  end

  test "Hexadecimal to Decial" do
    assert(Convert.Hexadecimal.to_decimal("A0") == 160)
    assert(Convert.Hexadecimal.to_decimal('A0') == 160)
    assert(Convert.Hexadecimal.to_decimal(["A", "0"]) == 160)
  end

  test "Hexadecimal to Binary list" do
    assert(Convert.Hexadecimal.to_binary_list("A0") == '10100000')
    assert(Convert.Hexadecimal.to_binary_list('A0') == '10100000')
    assert(Convert.Hexadecimal.to_binary_list(["A", "0"]) == '10100000')
  end

  test "Hexadecimal to Binary integer list" do
    assert(Convert.Hexadecimal.to_binary_list_integer("A0") == [1,0,1,0,0,0,0,0])
    assert(Convert.Hexadecimal.to_binary_list_integer('A0') == [1,0,1,0,0,0,0,0])
    assert(Convert.Hexadecimal.to_binary_list_integer(["A", "0"]) == [1,0,1,0,0,0,0,0])
  end

  test "Hexadecimal to Binary string" do
    assert(Convert.Hexadecimal.to_binary_string("A0") == "10100000")
    assert(Convert.Hexadecimal.to_binary_string('A0') == "10100000")
    assert(Convert.Hexadecimal.to_binary_string(["A", "0"]) == "10100000")
  end

  test "Hexadecimal to Octal integer" do
    assert(Convert.Hexadecimal.to_octal_integer("A0") == 240)
    assert(Convert.Hexadecimal.to_octal_integer('A0') == 240)
    assert(Convert.Hexadecimal.to_octal_integer(["A", "0"]) == 240)
  end

  test "Hexadecimal to Octal list" do
    assert(Convert.Hexadecimal.to_octal_list("A0") == '240')
    assert(Convert.Hexadecimal.to_octal_list('A0') == '240')
    assert(Convert.Hexadecimal.to_octal_list(["A", "0"]) == '240')
  end

  test "Hexadecimal to Octal integer list" do
    assert(Convert.Hexadecimal.to_octal_list_integer("A0") == [2, 4, 0])
    assert(Convert.Hexadecimal.to_octal_list_integer('A0') == [2, 4, 0])
    assert(Convert.Hexadecimal.to_octal_list_integer(["A", "0"]) == [2, 4, 0])
  end

  test "Hexadecimal to Octal string" do
    assert(Convert.Hexadecimal.to_octal_string("A0") == "240")
    assert(Convert.Hexadecimal.to_octal_string('A0') == "240")
    assert(Convert.Hexadecimal.to_octal_string(["A", "0"]) == "240")
  end

  test "Octal to Decimal" do
    assert(Convert.Octal.to_decimal(240) == 160)
    assert(Convert.Octal.to_decimal("240") == 160)
    assert(Convert.Octal.to_decimal('240') == 160)
    assert(Convert.Octal.to_decimal([2, 4, 0]) == 160)
  end

  test "Octal to Binary list" do
    assert(Convert.Octal.to_binary_list(240) == '10100000')
    assert(Convert.Octal.to_binary_list("240") == '10100000')
    assert(Convert.Octal.to_binary_list('240') == '10100000')
    assert(Convert.Octal.to_binary_list([2, 4, 0]) == '10100000')
  end

  test "Octal to Binary integer list" do
    assert(Convert.Octal.to_binary_list_integer(240) == [1,0,1,0,0,0,0,0])
    assert(Convert.Octal.to_binary_list_integer("240") == [1,0,1,0,0,0,0,0])
    assert(Convert.Octal.to_binary_list_integer('240') == [1,0,1,0,0,0,0,0])
    assert(Convert.Octal.to_binary_list_integer([2, 4, 0]) == [1,0,1,0,0,0,0,0])
  end

  test "Octal to Binary string" do
    assert(Convert.Octal.to_binary_string(240) == "10100000")
    assert(Convert.Octal.to_binary_string("240") == "10100000")
    assert(Convert.Octal.to_binary_string('240') == "10100000")
    assert(Convert.Octal.to_binary_string([2, 4, 0]) == "10100000")
  end

  test "Octal to Hexadecimal list" do
    assert(Convert.Octal.to_hex_list(240) == 'A0')
    assert(Convert.Octal.to_hex_list("240") == 'A0')
    assert(Convert.Octal.to_hex_list('240') == 'A0')
    assert(Convert.Octal.to_hex_list([2, 4, 0]) == 'A0')
  end

  test "Octal to Hexadecimal list string" do
    assert(Convert.Octal.to_hex_list_string(240) == ["A", "0"])
    assert(Convert.Octal.to_hex_list_string("240") == ["A", "0"])
    assert(Convert.Octal.to_hex_list_string('240') == ["A", "0"])
    assert(Convert.Octal.to_hex_list_string([2, 4, 0]) == ["A", "0"])
  end

  test "Octal to Hexadecimal string" do
    assert(Convert.Octal.to_hex_string(240) == "A0")
    assert(Convert.Octal.to_hex_string("240") == "A0")
    assert(Convert.Octal.to_hex_string('240') == "A0")
    assert(Convert.Octal.to_hex_string([2, 4, 0]) == "A0")
  end
end
