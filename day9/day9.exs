defmodule Day9 do
  def part_one(input) do
    String.split(input, "\n")
    |> Enum.map(&calculate_differences/1)
  end

  def calculations(values) do
    Enum.map(values, fn pair ->
      a = String.to_integer(Enum.at(pair, 0))
      b = String.to_integer(Enum.at(pair, 1))
      abs(a - b)
    end)
  end

  def calculate_differences(line) do
    differences =
      String.split(line, " ")
      |> Enum.chunk_every(2)
      |> Enum.map(fn pair ->
        a = String.to_integer(Enum.at(pair, 0))
        b = String.to_integer(Enum.at(pair, 1))
        abs(a - b)
      end)
      |> IO.inspect()

    calculate_differences(differences, 0)
  end

  def calculate_differences(values, value) do
    if 0 not in values do
      value + List.last(values)
    else
    end
  end
end

{_, input} = File.read(Enum.at(System.argv(), 0))

IO.puts("Part one: #{Day9.part_one(input)}")
