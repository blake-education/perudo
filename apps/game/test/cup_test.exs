defmodule CupTest do
  use ExUnit.Case

  test "cup has desired dice count" do
    [1, 2, 3, 4, 5]
    |> Enum.all?(fn(dice_count) ->
      Cup.new(dice_count) |> length == dice_count
    end)
    |> assert
  end

  test "dice have face value of 1-6" do
    [1, 2, 3, 4, 5]
    |> Enum.map(&Cup.new/1)
    |> Enum.concat()
    |> Enum.all?(fn(value) -> value >= 1 and value <= 6 end)
    |> assert
  end
end
