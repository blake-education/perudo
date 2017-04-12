defmodule CupTest do
  use ExUnit.Case
  alias Game.Cup

  test "cup has desired dice count" do
    [1, 2, 3, 4, 5]
    |> Enum.all?(fn(dice_count) ->
      Cup.generate(dice_count) |> length == dice_count
    end)
    |> assert
  end

  test "dice have face value of 1-6" do
    [1, 2, 3, 4, 5]
    |> Enum.map(&Cup.generate/1)
    |> Enum.concat()
    |> Enum.all?(fn(value) -> value >= 1 and value <= 6 end)
    |> assert
  end

  test "count_for" do
    assert Cup.count_for(2, [1, 2, 3 ,4]) == 2
    assert Cup.count_for(2, [1, 1, 1 ,1]) == 4
    assert Cup.count_for(3, [2, 2, 2 ,2]) == 0
    assert Cup.count_for(3, [2, 3, 2 ,3]) == 2
  end
end