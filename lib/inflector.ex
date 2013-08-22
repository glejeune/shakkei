defmodule Inflector do
  @doc """
  By default, camelize converts strings to UpperCamelCase. 
  If the second argument to camelize is set to false then camelize produces lowerCamelCase.

  camelize will also convert '/' to '.' which is useful for converting paths to namespaces.

  ## Example

      iex> Inflector.camelize("hello_beautiful/world")
      "HelloBeautiful.World"
      iex> Inflector.camelize("hello_beautiful/world", false)
      "helloBeautiful.World"
  """
  def camelize(term, upper_first_letter // true) when is_bitstring(term) and is_boolean(upper_first_letter) do
    if upper_first_letter == true do
      term = String.capitalize(term)
    end

    term = Regex.split(%r/_/, term) 
    |> Enum.with_index 
    |> Enum.reduce("", fn(item, acc) ->
      case item do
        {term, 0} -> acc <> term
        {term, _} -> acc <> String.capitalize(term)
      end
    end)
    
    Regex.split(%r/\//, term) 
    |> Enum.with_index 
    |> Enum.reduce("", fn(item, acc) ->
      case item do
        {term, 0} -> acc <> term
        {term, _} -> acc <> "." <> String.capitalize(term)
      end
    end)
  end

  @doc """
  Makes an underscored, lowercase form from the expression in the string.

  Changes ‘.’ to ‘/’ to convert namespaces to paths.

  ## Example

      iex> Inflector.underscore("HelloBeautiful.World")
      "hello_beautiful/world"
  """
  def underscore(term) when is_bitstring(term) do
    term = Regex.split(%r/\./, term)
    |> Enum.with_index
    |> Enum.reduce("", fn(item, acc) ->
      case item do
        {term, 0} -> acc <> term
        {term, _} -> acc <> "/" <> downcase_first_letter(term)
      end
    end)

    Regex.split(%r/\./, Regex.replace(%r/[A-Z]/, term, ".&"))
    |> Enum.drop_while(&(&1 == ""))
    |> Enum.with_index
    |> Enum.reduce("", fn(item, acc) ->
      case item do
        {term, 0} -> acc <> String.downcase(term)
        {term, _} -> acc <> "_" <> String.downcase(term)
      end
    end)
  end

  defp downcase_first_letter(term) when is_bitstring(term) do
    downcase_first_letter(bitstring_to_list(term))
  end
  defp downcase_first_letter([first|rest]) when first >= ?A and first <= ?Z do
    downcase_first_letter([first + (?a - ?A)] ++ rest)
  end
  defp downcase_first_letter([first|rest]) do
    list_to_bitstring([first] ++ rest)
  end

  @doc """
  Replaces underscores with dashes in the string.

  ## Example

      iex> Inflector.dasherize("bonjour_le-monde")
      "bonjour-le-monde"
  """
  def dasherize(term) when is_bitstring(term) do
    String.replace(term, "_", "-")
  end
end

