defmodule Day4 do
  def part_one(input) do
    String.split(input, "\n")
    |> Enum.map(fn game ->
      find_winning_numbers(game)
    end)
    |> Enum.map(fn game ->
      calculate_points(game)
    end)
    |> Enum.sum()
  end

  def part_two(input) do
    String.split(input, "\n")
    |> Enum.map(fn game ->
      find_winning_numbers(game)
      |> length()
    end)
    |> total_scratchcards()
    |> Enum.sum()
  end

  def total_scratchcards(games) do
    # Work through the problem going backwards.
    Enum.reverse(games)
    |> total_scratchcards([])
  end

  def total_scratchcards([head | tail], total_instances) do
    if head == 0 do
      total_scratchcards(tail, [1 | total_instances])
    else
      sum =
        Enum.slice(total_instances, 0..(head - 1))
        |> Enum.sum()

      total_scratchcards(tail, [sum + 1 | total_instances])
    end
  end

  def total_scratchcards([], total_instances) do
    total_instances
  end

  def find_winning_numbers(game) do
    cards =
      Enum.at(String.split(game, ": "), 1)
      |> String.split(" | ", trim: true)

    MapSet.intersection(MapSet.new(my_numbers(cards)), MapSet.new(winning_numbers(cards)))
    |> Enum.map(fn x ->
      {number, ""} = Integer.parse(x)
      number
    end)
  end

  def calculate_points(game) do
    if length(game) == 0 do
      0
    else
      2 ** (length(game) - 1)
    end
  end

  def my_numbers(game) do
    String.split(Enum.at(game, 0), " ", trim: true)
  end

  def winning_numbers(game) do
    String.split(Enum.at(game, 1), " ", trim: true)
  end
end

{_, input} = File.read(Enum.at(System.argv(), 0))
IO.puts("Part one: #{Day4.part_one(input)}")
IO.puts("Part two: #{Day4.part_two(input)}")
