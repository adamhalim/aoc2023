defmodule Day5 do
  def part_one(input) do
    lines =
      String.split(input, "\n")
      |> Enum.chunk_by(fn x -> x != "" end)
      |> Enum.filter(fn x -> Enum.at(x, 0) != "" end)

    seeds =
      Enum.at(lines, 0)
      |> Enum.at(0)
      |> String.split("seeds: ", trim: true)
      |> Enum.at(0)
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)

    maps =
      Enum.drop(lines, 1)
      |> Enum.map(fn map ->
        Enum.drop(map, 1)
      end)

    Enum.map(seeds, fn seed ->
      calculate_ranges(maps, seed)
    end)
    |> Enum.min()
  end

  def part_two(input) do
    lines =
      String.split(input, "\n")
      |> Enum.chunk_by(fn x -> x != "" end)
      |> Enum.filter(fn x -> Enum.at(x, 0) != "" end)

  end

  def find_range([], value, _found) do
    value
  end

  def find_range([ head | tail ], value, found) do
    if found do
      value
    else
      {dest, src, length} = get_map_values(head)
      if value in src..(src + length-1) do
        find_range(tail, value + (dest - src), true)
      else
        find_range(tail, value, false)
      end
    end
  end

  def calculate_ranges([head | tail], seed) do
    calculate_ranges(tail, find_range(head, seed, false))
  end

  def calculate_ranges([], seed) do
    seed
  end

  def get_map_values(map) do
    values =
      String.split(map, " ", trim: true)

    # dest src length
    {String.to_integer(Enum.at(values, 0)), String.to_integer(Enum.at(values, 1)),
     String.to_integer(Enum.at(values, 2))}
  end

end

{_, input} = File.read(Enum.at(System.argv(), 0))

IO.puts("Part one: #{Day5.part_one(input)}")
