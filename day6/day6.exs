defmodule Day6 do
  def part_one(input) do
    String.split(input, "\n")
    |> get_time_distance
    |> find_all_records
  end

  def part_two(input) do
    {times, distances} =
      String.split(input, "\n")
      |> get_time_distance

    {[Enum.join(times, "")], [Enum.join(distances, "")]}
    |> find_all_records()
  end

  def get_time_distance(input) do
    time_line = Enum.at(input, 0)
    distances_line = Enum.at(input, 1)

    times =
      String.split(time_line, " ", trim: true)
      |> List.delete_at(0)

    distances =
      String.split(distances_line, " ", trim: true)
      |> List.delete_at(0)

    {times, distances}
  end

  def find_all_records({times, distances}) do
    Enum.zip(times, distances)
    |> Enum.map(fn {time, distance} ->
      number_of_records(String.to_integer(time), String.to_integer(distance))
    end)
    |> Enum.product()
  end

  def number_of_records(time, distance) do
    # T   7
    # d   9
    # v = t_p

    # t_r = T - t_p <=>
    # t_r = T - v

    # s = v * t_r
    # s > d (9)

    # s = v * t_r <=>
    # s = v * (T - v)     <=>

    # v = v * T - v^2 > d <=>
    # v * T - v^2 > d

    # v^2 - vTv + d > 0
    # -> quadratic formula
    {x0, x1} = quadratic_formula(-time, distance)
    trunc(Float.ceil(x0) - Float.floor(x1) - 1)
  end

  def quadratic_formula(p, q) do
    {
      -p / 2 + ((p / 2) ** 2 - q) ** 0.5,
      -p / 2 - ((p / 2) ** 2 - q) ** 0.5
    }
  end
end

{_, input} = File.read(Enum.at(System.argv(), 0))

IO.puts("Part one: #{Day6.part_one(input)}")
IO.puts("Part two: #{Day6.part_two(input)}")
