defmodule CupTest do
  use ExUnit.Case

  test "cup has desired dice count" do
    [1, 2, 3, 4, 5]
    |> Enum.each(fn(dice_count) ->
      assert Cup.new(dice_count) |> length == dice_count
    end)
  end

  test "dice have face value of 1-6" do
    [1, 2, 3, 4, 5]
    |> Enum.map(&Cup.new/1)
    |> Enum.concat()
    |> Enum.each(fn(value) ->
      assert value >=1 and value <= 6
    end)
  end
end
