defmodule Day9 do
  def part_one(input) do
    lines = String.split(input, "\n")

    Enum.map(lines, fn line ->
      calculate_differences(line, [])
    end)
  end

  def calculate_differences(line, []) do
    history =
      String.split(line, " ", trim: true)
      |> Enum.map(&String.to_integer/1)

    differences = calculate_differences(history)
    done_with_differences(differences, List.last(differences))
    |> IO.inspect()
  end

  def calculate_differences([_head | _tail = []], differences) do
    differences
  end

  def calculate_differences([head | tail], differences) do
    difference = abs(head - List.first(tail))
    calculate_differences(tail, [difference | differences])
  end

  def calculate_differences([head | tail]) do
    difference = abs(head - List.first(tail))
    calculate_differences(tail, [difference])
  end

  def done_with_differences(differences, sum) do
    IO.inspect(differences)
    if 0 not in differences do
      calculate_differences(differences)
    else
      sum
    end
  end

  # def calculate_differences(values, value) do
  #   if 0 not in values do
  #     value + List.last(values)
  #   else
  #   end
  # end
end

{_, input} = File.read(Enum.at(System.argv(), 0))

IO.puts("Part one: #{Day9.part_one(input)}")
