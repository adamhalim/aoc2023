defmodule Day1 do
  def part_one(input) do
    String.split(input, "\n", trim: true)
    |> remove_letters()
    |> concat_strings()
    |> Enum.sum()
  end

  def remove_letters(lines) do
    Enum.map(lines, fn line -> String.replace(line, ~r/[A-Za-z]/, "", trim: true) end)
  end

  def concat_strings(digit_list) do
    Enum.map(digit_list, fn digits ->
      Kernel.to_charlist(digits)
      String.to_integer("#{String.at(digits, 0)}#{String.at(digits, -1)}")
    end)
  end

  def part_two(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&replace_first_number/1)
    |> remove_letters()
    |> concat_strings()
    |> Enum.sum()
  end

  def replace_first_number(line) do
    numbers = %{
      "one" => "1",
      "two" => "2",
      "three" => "3",
      "four" => "4",
      "five" => "5",
      "six" => "6",
      "seven" => "7",
      "eight" => "8",
      "nine" => "9"
    }

    first_replaced =
      String.replace(
        line,
        Map.keys(numbers),
        fn match ->
          numbers[match]
        end,
        global: false
      )

    "#{first_replaced}#{find_last_number(line)}"
  end

  def find_last_number(line) do
    find_last_number(to_charlist(line), 0)
  end

  def find_last_number([], digit) do
    digit
  end

  def find_last_number([head | tail], digit) do
    numbers = %{
      "one" => "1",
      "two" => "2",
      "three" => "3",
      "four" => "4",
      "five" => "5",
      "six" => "6",
      "seven" => "7",
      "eight" => "8",
      "nine" => "9"
    }

    case Integer.parse("#{[head]}") do
      {_, ""} ->
        find_last_number(to_charlist(tail), [head])

      :error ->
        line = "#{[head]}#{tail}"

        case return_starts_with(line, Map.keys(numbers)) do
          nil -> find_last_number(tail, digit)
          digit -> find_last_number(tail, numbers[digit])
        end
    end
  end

  def return_starts_with(line, [number | tail]) do
    case String.starts_with?(line, number) do
      true ->
        number

      false ->
        return_starts_with(line, tail)
    end
  end

  def return_starts_with(_line, []) do
    nil
  end
end

{_, input} = File.read("input.txt")

IO.puts("Part one: #{Day1.part_one(input)}")
IO.puts("Part two: #{Day1.part_two(input)}")
