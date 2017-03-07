defmodule CupTest do
  use ExUnit.Case

  test "cup has desired dice count" do
    [1, 2, 3, 4, 5]
    |> Enum.map(fn dice_count ->
      assert Cup.new(dice_count) |> length == dice_count
    end)
  end
end
