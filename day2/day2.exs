defmodule Day2 do
  def part_one(input) do
    cubes = %{
      "red" => 12,
      "green" => 13,
      "blue" => 14
    }

    lines = String.split(input, "\n", trim: true)

    Enum.map(lines, fn line -> valid_games(line, cubes) end)
    |> Enum.sum()
  end

  def valid_games(line, cubes) do
    String.split(line, " ", parts: 3)
    |> valid_game(cubes)
  end

  def valid_game(line, cubes) do
    game = Enum.at(line, 2)
    id = Enum.at(line, 1)

    String.split(game, "; ", trim: true)
    |> Enum.map(fn set ->
      String.split(set, ", ", trim: true)
      |> Enum.map(fn subset ->
        game_valid(subset, cubes)
      end)
    end)
    |> Enum.map(fn valid ->
      Enum.member?(valid, false)
    end)
    |> add_id_if_valid_game(id)
  end

  def add_id_if_valid_game(valid_games, id) do
    if !Enum.member?(valid_games, true) do
      String.to_integer(Enum.at(String.split(id, ":"), 0))
    else
      0
    end
  end

  def game_valid(subset, cubes) do
    s = String.split(subset, " ", parts: 2)
    {number, colour} = subset_values(subset)
    cubes[colour] >= number
  end

  def part_two(input) do
    lines = String.split(input, "\n", trim: true)

    Enum.map(lines, fn line -> get_power_of_cubes(line) end)
    |> Enum.sum()
    |> IO.inspect()
  end

  def subset_values(subset) do
    s = String.split(subset, " ", parts: 2)
    number = String.to_integer(Enum.at(s, 0))
    colour = Enum.at(s, 1)
    {number, colour}
  end

  def get_power_of_cubes(line) do
    Enum.at(String.split(line, ": ", parts: 2, trim: true), 1)
    |> String.replace(";", ",")
    |> String.split(", ", trim: true)
    |> get_min_values(0, 0, 0)
    |> Tuple.product()
  end

  def get_min_values([head | tail], red, green, blue) do
    {number, colour} = subset_values(head)

    case colour do
      "red" ->
        if number > red do
          get_min_values(tail, number, green, blue)
        else
          get_min_values(tail, red, green, blue)
        end

      "green" ->
        if number > green do
          get_min_values(tail, red, number, blue)
        else
          get_min_values(tail, red, green, blue)
        end

      "blue" ->
        if number > blue do
          get_min_values(tail, red, green, number)
        else
          get_min_values(tail, red, green, blue)
        end
    end
  end

  def get_min_values([], red, green, blue) do
    {red, green, blue}
  end
end

{_, input} = File.read("input.txt")

IO.puts("Part one: #{Day2.part_one(input)}")
Day2.part_two(input)
